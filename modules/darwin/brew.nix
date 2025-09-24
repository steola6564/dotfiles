{ config, pkgs, ... }:

{
  # Homebrew integration for macOS
  homebrew = {
    enable = true;

    # 自動で不要なパッケージを削除する
    onActivation.cleanup = "zap";

    # 通常の brew formula
    brews = [
      # "wget"
    ];

    # cask (GUI apps / fonts)
    casks = [
      "font-jetbrains-mono-nerd-font"
      "font-fira-code-nerd-font"
      "nikitabobko/tap/aerospace"
      "brave-browser"
      "jordanbaird-ice"
      "discord"
      "slack"
      "visual-studio-code"
      "alacritty"
      # "visual-studio-code"
    ];

    onActivation.upgrade = true;
  };
}

