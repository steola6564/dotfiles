# modules/home/home.nix
{ config, pkgs, lib ? pkgs.lib, ... }:
{
  imports = [
    ./base/git.nix
    ./base/shell.nix
  ];

  home.packages = with pkgs; [
    repgrep
    fd
    devbox 
    pixi
    volta
    uv
    tree
    bat
    git
    zellij
  ];

   # Volta 本体は pkgs.volta でインストール済み前提
  home.sessionVariables = {
    VOLTA_HOME = "${config.home.homeDirectory}/.volta";
  };

  # PATH へ shim を追加（先頭に来るように）
  home.sessionPath = [
    "${config.home.homeDirectory}/.volta/bin"
  ];

  home.stateVersion = "25.05";
}

