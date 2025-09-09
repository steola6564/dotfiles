{ config, lib, pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      noto-fonts noto-fonts-cjk-sans noto-fonts-cjk-serif noto-fonts-emoji
      source-han-sans-japanese
      nerd-fonts.jetbrains-mono nerd-fonts.fira-code
    ];
    fontconfig = {
      enable = true;
      allowBitmaps = false;
      antialias = true;
      hinting.enable = true;
      hinting.style = "slight";
      subpixel.rgba = "rgb";
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "Noto Serif" ];
        sansSerif = [ "Noto Sans CJK JP" "Noto Sans" ];
        monospace = [ "Noto Sans Mono CJK JP" "Noto Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
