{ config, pkgs, ... }:
{
  home.username = "steola";
  home.homeDirectory = "/Users/steola";
  home.stateVersion = "25.05"; # nixpkgsと合わせる

  programs.git.enable = true;
  programs.zsh.enable = true;

  home.packages = with pkgs; [
    # htop
    neovim
    # jq
  ];
}

