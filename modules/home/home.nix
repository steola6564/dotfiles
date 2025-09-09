# modules/home/home.nix
{ pkgs, lib ? pkgs.lib, ... }:
let
  isLinux  = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in {
  imports = [
    ./base/git.nix
    ./base/shell.nix
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    ./linux/brave.nix
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    #  ./darwin/...
  ];

  home.packages = with pkgs; [
    brave
    repgrep
    fd
    volta
    uv
    tree
    bat
  ];

  # 任意：Chromium/Electron系をWayland化（推奨）
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.stateVersion = "25.05";
}

