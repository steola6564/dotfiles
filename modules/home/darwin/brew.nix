{ config, pkgs, ... }:
{
  programs.zsh.initContent = ''
    # Homebrew (Apple Silicon)
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  '';

}
