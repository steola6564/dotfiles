{ config, pkgs, lib, ... }:

{
  # 他の設定…

  system.defaults = {
    dock = {
      autohide = true;           # Dock を自動で隠す
      mru-spaces = false;         # 最近使ったスペース順に整理するのをオフ
      persistent-apps = [
      ];
      # 他にあれば Dock の位置やサイズなどのオプションも入れられるが、
      # ドキュメントにそのオプションが存在するか確認が必要
    };
  };

  # Dock 設定を反映（ログアウト／再起動、または activation script が必要なことがある）
}

