{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      # === Svelte / Frontend ===
      (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          publisher = "1yib";
          name = "svelte-bundle";
          version = "latest";
        };
      })
      ardenivanov.svelte-intellisense
      astro-build.astro-vscode
      fivethree.vscode-svelte-snippets
      svelte.svelte-vscode
      yandeu.five-server

      # === Python ===
      ms-python.debugpy
      ms-python.python
      ms-python.vscode-pylance
      ms-python.vscode-python-envs

      # === Jupyter ===
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow

      # === C/C++ ===
      ms-vscode.cmake-tools
      ms-vscode.cpptools
      ms-vscode.cpptools-extension-pack
      ms-vscode.cpptools-themes
      ms-vscode.makefile-tools
      twxs.cmake

      # === Docker / Remote ===
      ms-azuretools.vscode-containers
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-containers

      # === LSP / Formatter / Linter ===
      biomejs.biome
      charliermarsh.ruff
      jnoortheen.nix-ide

      # === Other utilities ===
      evilz.vscode-reveal
      janisdd.vscode-edit-csv
      mattn.lisp
      mechatroner.rainbow-csv
      ms-ceintl.vscode-language-pack-ja
      ms-vsliveshare.vsliveshare
      ritwickdey.liveserver
      vscode-icons-team.vscode-icons
      yzane.markdown-pdf
      yzhang.markdown-all-in-one
    ];
  };
}

