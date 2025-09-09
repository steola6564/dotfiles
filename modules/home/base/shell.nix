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

    initExtra = ''
      source ${p10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ~/.p10k.zsh
    '';
  };

  home.file.".p10k.zsh".source = ../p10k.zsh;

  # Starship prompt は zsh 専用の p10k を使う限り不要。
  # ただし将来的に p10k で制約や問題が出た際に切り替え可能とするためコメントアウトして保持。
  # programs.starship.enable = true;
}
