{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, unstable, agenix, ... }@inputs: {
    # === ここ：overlay 定義 ===
    overlays.default = (final: prev:
      let
        ver = "2025.8.1";  # ← 使いたいリリースのタグに合わせて変更
        urlFor = system: {
          "x86_64-linux" = "https://github.com/cloudflare/cloudflared/releases/download/${ver}/cloudflared-linux-amd64";
        }.${system};
        shaFor = system: {
          # 下の prefetch 手順で得た値に差し替え
          "x86_64-linux" = "sha256-pmNTAEGX7kwfy2hUkgOCSIK7piN4rU0A0jS9uCUfERQ=";
        }.${system};
      in {
        cloudflared-bin = final.stdenvNoCC.mkDerivation {
          pname = "cloudflared-bin";
          version = ver;
          src = final.fetchurl {
            url = urlFor final.stdenv.hostPlatform.system;
            sha256 = shaFor final.stdenv.hostPlatform.system;
          };
          dontUnpack = true;
          installPhase = ''
            install -Dm755 "$src" "$out/bin/cloudflared"
          '';
          meta = with final.lib; {
            description = "Cloudflare Tunnel daemon (prebuilt binary)";
            homepage = "https://developers.cloudflare.com/cloudflare-one/";
            # 公式配布バイナリはOSSでないので unfree 指定
            license = licenses.unfree;
            platforms = [ "x86_64-linux" ];
            mainProgram = "cloudflared";
          };
        };
      }
    );


    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos-server = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
	({ config, pkgs, ...}: {
          # ← 既存設定の中にこれを追加
          nixpkgs.config = {
            allowUnfree = true;
            # Terraform だけ許可（名前マッチ）
            allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [ "terraform" ];
          };

	  # === ここ：overlay を有効化 ===
          nixpkgs.overlays = [ self.overlays.default ];

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
	    jq
	    (pkgs.writeShellScriptBin "tf" ''
              set -euo pipefail
              cfg='${config.age.secrets."tf/cloudflare.json".path}'
              export TF_VAR_cloudflare_api_token="$(jq -r .api_token "$cfg")"
              export TF_VAR_cloudflare_zone_id="$(jq -r .zone_id "$cfg")"
              export TF_VAR_cloudflare_account_id="$(jq -r .account_id "$cfg")"
              export TF_VAR_tunnel_id="$(jq -r .tunnel_id "$cfg")"
              export TF_VAR_allow_email="$(jq -r .allow_email "$cfg")"
              exec ${pkgs.terraform}/bin/terraform "$@"
            '')
	  ];

	  # cloudflared json encrypted with agenix
	  age.secrets."cloudflared/credentials" = {
	    file = ./secrets/cloudflared-credentials.age;
	    owner = "cloudflared";
	    group = "cloudflared";
	    mode  = "0400";
	  };

	  # 復号ファイルを steola に
          age.secrets."tf/cloudflare.json" = {
            file  = ./secrets/tf-cloudflare.json.age;
            owner = "steola";
            group = "users";
            mode  = "0400";
          };

	  # cloudflare resident + gwak tunnel
	  services.cloudflared = {
	    enable = true;
	    # ← ここがポイント：overlay の cloudflared-bin を使う
            package = pkgs.cloudflared-bin; 

	    tunnels."e34c4c53-0d57-44fc-a32d-62afedbe5c05" = {
	      # agenix passes the decrypted file to credentialsFile
	      credentialsFile = config.age.secrets."cloudflared/credentials".path;

	      # domain-specific routing. :Ex Guacamole (HTTP) is placed on port 8080
	      ingress = {
	        "terminal.niboratory.com" = "ssh://localhost:22";
	        # "terminal.niboratory.com" =  { service = "http://127.0.0.1:8000"; };
	      };
	      default = "http_status:404";
	    };
	  };
	})
      ];
    };
  };
}
