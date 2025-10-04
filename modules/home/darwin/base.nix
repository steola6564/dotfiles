{ config, pkgs, lib, ... }:
{
  home.username = "steola";
  home.homeDirectory = "/Users/steola";
  home.packages = with pkgs; [
    neovim
    # jq
    # htop
  ];

  xdg.configFile."alacritty/alacritty.toml".source =
    ./config/alacritty.toml;
}

