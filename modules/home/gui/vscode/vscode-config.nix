{ config, lib, pkgs, ... }:

let
  cfgDir = "${config.home.homeDirectory}/.vscode";
in {
  # VSCode 設定ファイルを Nix 管理に置き換える
  home.file."${cfgDir}/settings.json".source =
    ./../config/vscode/settings.json;

  home.file."${cfgDir}/extensions/extensions.json".source =
    ./../config/vscode/extensions.json;
}

