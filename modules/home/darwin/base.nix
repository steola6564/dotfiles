{ config, pkgs, lib, ... }:
{
  home.username = "steola";
  home.homeDirectory = "/Users/steola";
  home.packages = with pkgs; [
    neovim
    # jq
    # htop
  ];

  home.activation.setTrackpadSpeed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    /usr/bin/defaults write -g com.apple.trackpad.scaling -float 7.5
  '';

}

