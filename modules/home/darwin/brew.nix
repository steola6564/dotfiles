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
  # Home Manager 側で zsh に brew の PATH を通す
  programs.zsh.profileExtra = ''
    # Homebrew (Apple Silicon)
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  '';
}

