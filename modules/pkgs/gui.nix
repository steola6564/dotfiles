{ config, lib, pkgs, ... }:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    grim slurp wl-clipboard mako
    firefox brave
    alacritty waybar brightnessctl pavucontrol
    hyprland hyprpaper
    nautilus rofi-wayland xdg-desktop-portal-hyprland
  ];
}