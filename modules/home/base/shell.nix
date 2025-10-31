{ pkgs, ... }:
{
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

  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./config/starship.toml);
  };
}
