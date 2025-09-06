{ inputs, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    # OS / profiles
    ../../os/nixos.nix
    ../../profiles/base.nix
    ../../profiles/server.nix
    ../../profiles/dev.nix

    # 機能モジュール
    ../../modules/system/users.nix
    ../../modules/system/cloudflared-service.nix
    ../../modules/ops/agenix.nix
    ../../modules/ops/terraform.nix
  ];

  networking.hostName = "nixos-server";

  system.stateVersion = "25.05";
}

