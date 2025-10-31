# Devshells/poetry.nix
{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "poetry-dev";

  packages = with pkgs; [
    python312          # ここは自由に変更可能
    poetry
    zsh
  ];

  # (オプション) C拡張ビルドで必要なツール類
  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [
    openssl
    libffi
    zlib
  ];

  shellHook = ''
    echo "🐍 Poetry isolated shell"
    echo "Python: $(python --version)"
    echo "Poetry: $(poetry --version)"

    if [ -n "$ZSH_VERSION" ]; then
      echo "🌀 Current shell: Zsh"
    elif [ -n "$BASH_VERSION" ]; then
      echo "🪶 Current shell: Bash"
    else
      echo "💠 Current shell: $SHELL"
    fi

    if [ -z "$ZSH_VERSION" ]; then
      exec zsh
    fi

    # プロジェクトローカルに .venv を作る
    poetry config virtualenvs.in-project true --local
    poetry env use $(which python)
  '';
}

