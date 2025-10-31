{ config, pkgs, ... }:

{
  launchd.daemons.nix-gc = {
    enable = true;
    program = "${pkgs.nix}/bin/nix-collect-garbage";
    args = [ "-d" ];
    # 週1回、日曜深夜3時
    StartCalendarInterval = {
      Weekday = 0; # Sunday
      Hour = 3;
      Minute = 0;
    };
    StandardOutPath = "/tmp/nix-gc.log";
    StandardErrorPath = "/tmp/nix-gc.err";
  };
}

