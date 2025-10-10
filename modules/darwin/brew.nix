{ config, pkgs, ... }:

{
  # Homebrew integration for macOS
  homebrew = {
    enable = true;

    # 自動で不要なパッケージを削除する
    onActivation.cleanup = "zap";

    taps = [
      "FelixKratz/formulae"
    ];

    # 通常の brew formula
    brews = [
      # "wget"
      "FelixKratz/formulae/sketchybar"
    ];

    # cask (GUI apps / fonts)
    casks = [
      "font-jetbrains-mono-nerd-font"
      "font-fira-code-nerd-font"
      "nikitabobko/tap/aerospace"
      "deepl"
      "utm"
      "brave-browser"
      "discord"
      "slack"
      "visual-studio-code"
      "alacritty"
      "obsidian"
      "google-japanese-ime"
      "google-chrome"
      "raindropio"
      "zotero"
      "zoom"
    ];
    onActivation.upgrade = true;
  };
}

