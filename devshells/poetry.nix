# Devshells/poetry.nix
{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "poetry-dev";

  packages = with pkgs; [
    python312          # ここは自由に変更可能
    poetry
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

    # プロジェクトローカルに .venv を作る
    poetry config virtualenvs.in-project true --local
    poetry env use $(which python)
  '';
}

