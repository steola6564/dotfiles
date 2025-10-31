{ config, pkgs, ... }:

{
  launchd.daemons.nix-gc = {
  # launchdのログ出力設定は serviceConfig 経由で指定
    serviceConfig = {
      Label = "org.nix.gc";  # 任意ラベル（必須ではないが慣習的に推奨）
      Program = "${pkgs.nix}/bin/nix-collect-garbage";
      ProgramArguments = [ "${pkgs.nix}/bin/nix-collect-garbage" "-d" ];

      StartCalendarInterval = {
      # 週1回、日曜深夜3時
        Weekday = 0; # Sunday
        Hour = 3;
        Minute = 0;
      };

      StandardOutPath = "/tmp/nix-gc.log";
      StandardErrorPath = "/tmp/nix-gc.err";
    };
  };
}

