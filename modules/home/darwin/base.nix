{ config, pkgs, lib, ... }:
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

  home.activation.setTrackpadSpeed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    /usr/bin/defaults write -g com.apple.trackpad.scaling -float 7.5
  '';

}

