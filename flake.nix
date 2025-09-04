{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, agenix, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos-server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
	({ config, pkgs, ...}: {
	  # Enable the agenix NixOS module 
          imports = [ agenix.nixosModules.default ];

	  # root（起動時）が使う復号用の鍵を指定
          age.identityPaths = [ "/etc/age/host.agekey" ];

	  # agenix CLI
	  environment.systemPackages = with pkgs; [
	    agenix.packages.x86_64-linux.default
	    age
	    # unstable から age-plugin-ssh / ssh-to-age を取る
            # (inputs.unstable.legacyPackages.x86_64-linux.age-plugin-ssh)
            # (inputs.unstable.legacyPackages.x86_64-linux.ssh-to-age)
	  ];

	  # cloudflared json encrypted with agenix
	  age.secrets."cloudflared/credentials" = {
	    file = ./secrets/cloudflared-credentials.age;
	    owner = "root";
	    group = "root";
	    mode  = "0400";
	  };

	  # cloudflare resident + gwak tunnel
	  services.cloudflared = {
	    enable = true;

	    tunnels."e34c4c53-0d57-44fc-a32d-62afedbe5c05" = {
	      # agenix passes the decrypted file to credentialsFile
	      credentialsFile = config.age.secrets."cloudflared/credentials".path;

	      # domain-specific routing. :Ex Guacamole (HTTP) is placed on port 8080
	      ingress = {
	        "terminal.niboratory.com" =  { service = "http://127.0.0.1:8000"; };
	      };
	      default = "http_status:404";
	    };
	  };
	})
	# ./gwakamore.nix;
	# {
	#   services.gwakamore = {
	#     enable = true;
	#     userMapping = /var/lib/guacamole/user-mapping.xml;
	#     domain = "terminal.nibolish.com"
	#     credentialFile = ;
	#   };
	# }
      ];
    };
  };
}
