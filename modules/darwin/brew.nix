{ config, pkgs, ... }:

{
  # Homebrew integration for macOS
  homebrew = {
    enable = true;

    # 自動で不要なパッケージを削除する
    onActivation = { 
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

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
      "scroll-reverser"
      "nikitabobko/tap/aerospace"
      "chatgpt"
      # "chatgpt-atlas"
      "deepl"
      "utm"
      "steam"
      "brave-browser"
      "discord"
      "docker-desktop"
      "slack"
      "visual-studio-code"
      "alacritty"
      "obsidian"
      "tailscale-app"
      "google-japanese-ime"
      "google-chrome"
      "raindropio"
      "zotero"
      "zoom"
    ];
  };
}

