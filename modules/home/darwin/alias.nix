{ pkgs, ... }:

{
  programs.zsh.shellAliases = {
    # macOS では "gcc" 実体が Clang なので、
    # Nix 環境でも同様にエイリアスを付けておく。
    gcc = "clang";
    g++ = "clang++";
  };
}

