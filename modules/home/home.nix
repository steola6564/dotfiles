# modules/home/home.nix
{ pkgs, lib ? pkgs.lib, ... }:
{
  imports = [
    ./base/git.nix
    ./base/shell.nix
  ];

  home.packages = with pkgs; [
    repgrep
    fd
    volta
    uv
    tree
    bat
    git
  ];

  home.stateVersion = "25.05";
}

