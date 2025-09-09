{ pkgs, ... }: {
  home.packages = [ pkgs.brave ];

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

