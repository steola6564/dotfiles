{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim wget neovim git curl
    home-manager
  ];
}
