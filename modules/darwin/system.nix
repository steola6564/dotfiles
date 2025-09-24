{ config, pkgs, lib, ... }:

{
  # 他の設定…

  system.defaults = {
    dock = {
      autohide = true;           # Dock を自動で隠す
      mru-spaces = false;        # 最近使ったスペース順に整理するのをオフ
      show-recents = false;      # 「最近使ったアプリ」をDockに表示しない
      # Dock のアイコンサイズ（デフォルト 64、範囲 16〜128）
      tilesize = 20;
      # Dock の拡大表示を有効化
      magnification = true;
      # 拡大時の最大サイズ（デフォルト 128、範囲 16〜128）
      largesize = 85;
      # Dock の位置（bottom / left / right）
      orientation = "bottom";
      persistent-apps = [
        "/System/Applications/System Settings.app"
      ];
      # 他にあれば Dock の位置やサイズなどのオプションも入れられるが、
      # ドキュメントにそのオプションが存在するか確認が必要
    };
    trackpad = {
      Clicking = true;
    };
  };
}

