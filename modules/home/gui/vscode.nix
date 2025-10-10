{ pkgs, ... }:
let
  # nvfetcherが生成したソースを読み込む
  generated = import ./nvfetcher/generated.nix { inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools; };

  # nvfetcher管理の拡張をビルド
  nvExtensions = with pkgs.vscode-utils; [
    (buildVscodeMarketplaceExtension {
      mktplcRef = { publisher = "evilz"; name = "vscode-reveal"; version = generated."evilz.vscode-reveal".version; };
      vsix      = generated."evilz.vscode-reveal".src;
    })
    (buildVscodeMarketplaceExtension {
      mktplcRef = { publisher = "janisdd"; name = "vscode-edit-csv"; version = generated."janisdd.vscode-edit-csv".version; };
      vsix      = generated."janisdd.vscode-edit-csv".src;
    })
    (buildVscodeMarketplaceExtension {
      mktplcRef = { publisher = "mattn"; name = "Lisp"; version = generated."mattn.lisp".version; }; # ← name= "Lisp"
      vsix      = generated."mattn.lisp".src;  # ← 属性名も "mattn.Lisp"
    })
  ];
in {
  programs.vscode = {
    enable = true;
    extensions = (with pkgs.vscode-extensions; [
      # === Svelte / Frontend ===
      # (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        # mktplcRef = {
          # publisher = "1yib";
          # name = "svelte-bundle";
          # version = "latest";
          # sha256 = "sha256-…"; # nix-prefetch-url で取得
        # };
      # })
      # ardenivanov.svelte-intellisense
      astro-build.astro-vscode
      # fivethree.vscode-svelte-snippets
      svelte.svelte-vscode
      # yandeu.five-server

      # === Python ===
      ms-python.debugpy
      ms-python.python
      ms-python.vscode-pylance
      # ms-python.vscode-python-envs

      # === Jupyter ===
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      # ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow

      # === C/C++ ===
      ms-vscode.cmake-tools
      ms-vscode.cpptools
      ms-vscode.cpptools-extension-pack
      # ms-vscode.cpptools-themes
      ms-vscode.makefile-tools
      twxs.cmake

      # === Docker / Remote ===
      # ms-azuretools.vscode-containers
      # ms-azuretools.vscode-docker
      # ms-vscode-remote.remote-containers

      # === LSP / Formatter / Linter ===
      biomejs.biome
      charliermarsh.ruff
      jnoortheen.nix-ide

      # === Other utilities ===
      # (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        # mktplcRef = {
          # publisher = "evilz";
          # name = "vscode-reveal";
          # version = "latest";
          # sha256 = "sha256-…";
        # };
      # })
      # janisdd.vscode-edit-csv
      # mattn.lisp
      # mechatroner.rainbow-csv
      ms-ceintl.vscode-language-pack-ja
      # ms-vsliveshare.vsliveshare
      # ritwickdey.liveserver
      vscode-icons-team.vscode-icons
      # yzane.markdown-pdf
      yzhang.markdown-all-in-one
    ]) ++ nvExtensions;

    # UI からの上書きを防ぐ（反映されない時の定番対策）
    mutableExtensionsDir = false;  # コミュニティでも解決策として推奨例あり :contentReference[oaicite:3]{index=3}
  };
}

