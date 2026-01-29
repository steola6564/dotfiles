{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/system/base.nix
    ../../modules/pkgs/common.nix
    ../../modules/users/steola.nix
    ../../modules/home-manager.nix
  ];

  security.sudo.wheelNeedsPassword = false;

  programs.nix-ld.enable = true;

  wsl.enable = true;
  wsl.defaultUser = "steola";
  networking.hostName = "nixos-wsl";
  system.stateVersion = "25.05"; # Did you read the comment?
}
