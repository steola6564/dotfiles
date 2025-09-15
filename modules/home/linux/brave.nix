{ pkgs, ... }: {
  home.packages = [ pkgs.brave ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.desktopEntries."brave-wayland" = {
    name = "Brave (Wayland IME)";
    comment = "Chromium/Brave on Wayland with IME";
    exec = "${pkgs.brave}/bin/brave --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime %U";
    icon = "brave-browser";
    terminal = false;
    categories = [ "Network" "WebBrowser" ];
    type = "Application";
    mimeType = [ "text/html" "x-scheme-handler/http" "x-scheme-handler/https" ];
  };
}

