{ config, lib, pkgs, ... }:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
  vim wget neovim git curl
  grim slurp wl-clipboard mako
  firefox brave
  alacritty waybar brightnessctl pavucontrol
  hyprland hyprpaper
  nautilus rofi-wayland xdg-desktop-portal-hyprland
  home-manager
  ethtool
  ];
}
