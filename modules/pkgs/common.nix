{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim wget neovim git curl gh
    home-manager
  ];
}
