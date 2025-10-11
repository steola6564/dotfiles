{ pkgs, ... }:

{
  programs.zsh.shellAliases = {
    # Nix の clang を明示的に呼ぶ
    # Nix 環境でも同様にエイリアスを付けておく。
    cc = "clang";
    "c++" = "clang++";
  };
}

