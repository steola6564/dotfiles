{
  description = "NixOS/Darwin unified repo (方案A)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs @ { self, nixpkgs, unstable, agenix, ... }:
  let
    system = "x86_64-linux";
  in {
    overlays.default = import ./overlays/default.nix;

    nixosConfigurations.nixos-server = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };  # modules/ops/agenix.nix で使う
      modules = [
        ./hosts/nixos-server/configuration.nix

        # overlay を有効化 + unfree許可維持
        ({ pkgs, ... }: {
          nixpkgs = {
            overlays = [ self.overlays.default ];
            config = {
              allowUnfree = true;
              # 元の意図：terraform と cloudflared-bin を許可
              allowUnfreePredicate = pkg:
                builtins.elem (pkgs.lib.getName pkg) [ "terraform" "cloudflared-bin" ];
            };
          };
        })
      ];
    };
    nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
      ./hosts/nixos-desktop/configuration.nix
      ];
    };
  };
}

