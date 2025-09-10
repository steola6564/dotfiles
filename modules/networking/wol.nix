{ config, pkgs, lib, ... }:

let
  iface = "enp42s0"; # ← あなたの環境のNIC名
in
{
  systemd.services."wol@${iface}" = {
    description = "Enable Wake-on-LAN on ${iface}";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ethtool}/bin/ethtool -s ${iface} wol g";
    };
  };
}

