{ config, pkgs, ... }:
{
  home.username = "steola";
  home.homeDirectory = "/Users/steola";
  home.packages = with pkgs; [
    neovim
    alacritty
    # jq
    # htop
  ];
  programs.alacritty.enable = true;
}

