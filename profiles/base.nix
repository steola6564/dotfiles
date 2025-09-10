{ lib, pkgs, ... }: {
  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "jp106";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # cloudflared-bin を unfree 許可（保険）
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "cloudflared-bin" ];
}

