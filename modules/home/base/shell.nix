{ pkgs, ... }:
let
  p10k = if pkgs ? powerlevel10k
         then pkgs.powerlevel10k
         else pkgs.zsh-powerlevel10k;
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;

    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.config/oh-my-zsh/custom";
      plugins = [ "git" "z" "history" ];
    };

  };

  programs.starship.enable = true;
}
