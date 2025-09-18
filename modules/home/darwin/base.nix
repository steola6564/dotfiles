{ config, pkgs, ... }:
{
  home.username = "steola";
  home.homeDirectory = "/Users/steola";
  home.packages = with pkgs; [
    # htop
    # neovim
    # jq
    alacritty
  ];
  programs.neovim.enable = true;
  programs.alacritty.enable = true;
}

