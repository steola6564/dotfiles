{ inputs, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    # OS / profiles
    ../../profiles/server.nix
    ../../profiles/dev.nix

    # 機能モジュール
    ../../modules/system/base.nix
    ../../modules/system/boot.nix
    ../../modules/system/cloudflared-service.nix
    # ../../modules/services/nextcloud.nix
    ../../modules/users/steola.nix
    ../../modules/ops/agenix.nix
    ../../modules/ops/terraform.nix
    ../../modules/ui/fonts.nix
    ../../modules/home-manager.nix
  ];

  networking.hostName = "nixos-server";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  system.stateVersion = "25.05";
}

