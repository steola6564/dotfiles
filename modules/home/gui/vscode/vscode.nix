{ config, pkgs, ... }:

# let
#   # === nvfetcher 生成物 ===
#   generated = import ./nvfetcher/generated.nix {
#     inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools;
#   };

#   # === 拡張リスト ===
#   baseExtensions = import ./extensions.nix { inherit pkgs; };
#   nvExtensions   = import ./nvfetcher-extensions.nix { inherit pkgs generated; };
#
# in
{
  # extensions.json まで Nix 管理しているため一旦停止
  # imports = [
  #   ./vscode-config.nix
  # ];
  programs.vscode = {
    enable = true;

    # =============================================================

    # VS Code本体のみNix/Home Managerで管理する。
    # 拡張機能・settings・keybindingsはVS Code自身に管理させる。
    #
    # 理由:
    # - 拡張機能の更新頻度が高い
    # - VS Code自身の管理機能を使う方が運用が軽い
    # - Home Manager管理下では設定ファイルが実質read-onlyになり、
    #   VS Code側からの更新時にwrite/lock errorが発生した
    #
    # 以前のNix管理構成は履歴・復帰用としてリポジトリ内に保持する。
 
    # =============================================================

    # === VS Code extensions ===
    # 一旦 VS Code 自身に管理させる
    #
    # # Marketplace拡張を宣言的に固定
    # mutableExtensionsDir = true;
    #
    # # pkgs標準拡張 + nvfetcher管理拡張
    # extensions = baseExtensions ++ nvExtensions;

    # userSettings = {
    #   "editor.formatOnSave" = true;
    #   "editor.rulers" = [80 100];
    #   "files.autoSave" = "afterDelay";
    #   "files.trimTrailingWhitespace" = true;
    #   "window.zoomLevel" = 1;
    # };

    # keybindings = [
    #   {
    #     key = "ctrl+shift+t";
    #     command = "workbench.action.terminal.toggleTerminal";
    #   }
    # ];
  };
}

