{ config, lib, pkgs, ... }:
{
nixpkgs.config.allowUnfree = true;

time.timeZone = "Asia/Tokyo";

# Keep this in system/base so all hosts can share a common baseline.
system.stateVersion = "25.05"; # Do not change without reading the manual
}
