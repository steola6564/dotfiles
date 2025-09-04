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
	{
	  environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
	}
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
