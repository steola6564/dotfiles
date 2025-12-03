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
      largesize = 95;
      # Dock の位置（bottom / left / right）
      orientation = "bottom";
      persistent-apps = [
        "/System/Applications/App Store.app"
	"/Applications/Safari.app"
        "/Applications/Brave Browser.app"
        "/Applications/Google Chrome.app"
        "/System/Applications/Mail.app"
        "/Applications/Visual Studio Code.app"
	"/System/Applications/Notes.app"
        "/Applications/UpNote.app"
        "/Applications/Raindrop.io.app"
        "/Applications/Zotero.app"
        "/Applications/Obsidian.app"
        "/Applications/Discord.app"
        "/Applications/LINE.app"
        "/Applications/Alacritty.app"
        "/System/Applications/System Settings.app"
      ];
      # 他にあれば Dock の位置やサイズなどのオプションも入れられるが、
      # ドキュメントにそのオプションが存在するか確認が必要
      # ★ Mission Control: ウィンドウをアプリごとにグループ化
      expose-group-apps = true;
    };
    # trackpad = {
      # Clicking = true;
    # };
    # Finder 設定
    finder = {
      AppleShowAllExtensions = true; # 拡張子を常に表示
      ShowPathbar = true;            # パスバーを表示
      ShowStatusBar = true;          # ステータスバーを表示
      # FXPreferredViewStyle = "Nlsv"; # デフォルト表示形式 (List View)
    };
    # Global 設定
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";  # ダークモード
      AppleShowAllFiles = true;      # 隠しファイルを表示
    };
    screencapture = {
      # スクリーンショットの保存先ディレクトリを作らないといけない
      location = "/Users/steola/Pictures/ScreenShots"; # 保存先
      type = "png";                                    # フォーマット
    };
  };
  # system.activationScripts.setTrackpadScaling = {
    # text = ''
       #/usr/bin/defaults write -g com.apple.trackpad.scaling -float 7.5
    # '';
  # };
  # Touch ID for sudo (トップレベルで指定)
  security.pam.services.sudo_local.touchIdAuth = true;
}

