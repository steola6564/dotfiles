{ config, lib, pkgs, hostname ? null, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.steola = { ... }: {
      imports = [
        ../modules/home/home.nix
      ] ++ lib.optionals (config.networking.hostName == "nixos-desktop") [
        ../profiles/home/desktop.nix
      ] ++ lib.optionals (config.networking.hostName == "nixos-server") [
        ../profiles/home/server.nix
      ] ++ lib.optionals (hostname == "darwin-air") [
        ../profiles/home/air.nix
      ];
    };
  };
}

# NOTE: Depending on where you place home-manager.nix, adjust the import path
# to ../../modules/home/home.nix when importing from the host file.
