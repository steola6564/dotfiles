# modules/home/home.nix
{ pkgs, ... }:
{
  # 必要に応じて追記していく
  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.starship.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fd
  ];

  home.stateVersion = "25.05";
}

