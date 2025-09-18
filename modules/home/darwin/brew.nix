{ config, pkgs, ... }:

{
  # Homebrew integration for macOS
  homebrew = {
    enable = true;

    # 自動で不要なパッケージを削除する
    cleanup = "zap";

    # 追加の tap
    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
    ];

    # 通常の brew formula
    brews = [
      # "wget"
      # "git"
      # "htop"
    ];

    # cask (GUI apps / fonts)
    casks = [
      "font-jetbrains-mono-nerd-font"
      "font-fira-code-nerd-font"
      # "alacritty"
      # "visual-studio-code"
    ];
  };
}

