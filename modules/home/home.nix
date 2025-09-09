# modules/home/home.nix
{ pkgs, ... }:
{
  # Brave 本体はそのまま入れる
  home.packages = with pkgs; [
    brave
    repgrep
    fd
  ];

  # フラグ付きランチャー（.desktop）を作成
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

  # 任意：Chromium/Electron系をWayland化（推奨）
  home.sessionVariables.NIXOS_OZONE_WL = "1";


  # 必要に応じて追記していく
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.starship.enable = true;

  home.stateVersion = "25.05";
}

