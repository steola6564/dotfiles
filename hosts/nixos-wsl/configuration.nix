{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/system/base.nix
    ../../modules/pkgs/common.nix
    # ../../modules/home-manager.nix
  ];

  environment.systemPackages = with pkgs; [
    vim wget neovim git curl gh
  ];

  users.users.steola = {
    isNormalUser = true;
    home = "/home/steola";
    description = "steola";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;

  wsl.enable = true;
  wsl.defaultUser = "steola";
  networking.hostName = "nixos-wsl";
  system.stateVersion = "25.05"; # Did you read the comment?
}
