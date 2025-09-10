{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
