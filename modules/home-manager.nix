{ config, lib, pkgs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.steola = import ../modules/home/home.nix; # relative to this file if you include differently, adjust path
  };
}

# NOTE: Depending on where you place home-manager.nix, adjust the import path
# to ../../modules/home/home.nix when importing from the host file.
