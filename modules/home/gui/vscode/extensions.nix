{ pkgs }:

with pkgs.vscode-extensions; [
  # === Core ===
  astro-build.astro-vscode
  biomejs.biome
  charliermarsh.ruff
  jnoortheen.nix-ide

  # === Python ===
  # ms-python.debugpy
  # ms-python.python
  # ms-python.vscode-pylance
  # ms-toolsai.jupyter
  # ms-toolsai.vscode-jupyter-slideshow

  # === C/C++ ===
  ms-vscode.cmake-tools
  ms-vscode.cpptools
  ms-vscode.cpptools-extension-pack
  ms-vscode.makefile-tools
  twxs.cmake

  # === Localization & UI ===
  ms-ceintl.vscode-language-pack-ja
  vscode-icons-team.vscode-icons

  # === svelte ===
  svelte.svelte-vscode

  # === Markdown ===
  yzhang.markdown-all-in-one
]

