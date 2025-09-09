# modules/home/home.nix
{ pkgs, ... }:
let
  # powerlevel10k の属性名差異に両対応
  p10k = if pkgs ? powerlevel10k
         then pkgs.powerlevel10k
         else pkgs.zsh-powerlevel10k;
in
{
  # Brave 本体はそのまま入れる
  home.packages = with pkgs; [
    brave
    repgrep
    fd
    volta
    uv
    tree
    bat
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
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;

    oh-my-zsh = {
      enable =true;
      custom = "$HOME/.config/oh-my-zsh/custom";
      plugins = [ "git" "z" "history" ];
      # theme = "powerlevel10k/powerlevel10k";
    };

    initExtra = ''
      source ${p10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ~/.p10k.zsh
    '';
  };

  
  home.file.".p10k.zsh".source = ./p10k.zsh;

  programs.git.enable = true;
  programs.starship.enable = true;

  home.stateVersion = "25.05";
}

