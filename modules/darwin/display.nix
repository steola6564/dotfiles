{ config, pkgs, ... }:
{
  homebrew = {
    enable = true;
    brews = [ "displayplacer" ];
  };

  system.activationScripts.setDisplay.text = ''
    /opt/homebrew/bin/displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1710x1112 hz:60 color_depth:8 scaling:on origin:(0,0) degree:0"
  '';
}

