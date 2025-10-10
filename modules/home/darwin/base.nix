{ config, pkgs, lib, ... }:
{
  home.username = "steola";
  home.homeDirectory = "/Users/steola";
  home.packages = with pkgs; [
    neovim
    clang
    # jq
    # htop
  ];

  xdg.configFile."alacritty/alacritty.toml".source =
    ../gui/config/alacritty.toml;
}

