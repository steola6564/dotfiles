{ config, pkgs, ... }:

let
  # === nvfetcher 生成物 ===
  generated = import ./nvfetcher/generated.nix {
    inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools;
  };

  # === 拡張リスト ===
  baseExtensions = import ./extensions.nix { inherit pkgs; };
  nvExtensions   = import ./nvfetcher-extensions.nix { inherit pkgs generated; };

in
{
  imports = [
    ./vscode-config.nix
  ];
  programs.vscode = {
    enable = true;

    # Marketplace拡張を宣言的に固定
    mutableExtensionsDir = true;

    # pkgs標準拡張 + nvfetcher管理拡張
    extensions = baseExtensions ++ nvExtensions;

    userSettings = {
      "editor.formatOnSave" = true;
      "editor.rulers" = [80 100];
      "files.autoSave" = "afterDelay";
      "files.trimTrailingWhitespace" = true;
      "window.zoomLevel" = 1;
    };

    keybindings = [
      {
        key = "ctrl+shift+t";
        command = "workbench.action.terminal.toggleTerminal";
      }
    ];
  };
}

