{ inputs, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix

    # OS / profiles
    ../../profiles/base.nix
    ../../profiles/server.nix
    ../../profiles/dev.nix

    # 機能モジュール
    ../../modules/system/boot.nix
    ../../modules/system/cloudflared-service.nix
    ../../modules/users/steola.nix
    ../../modules/ops/agenix.nix
    ../../modules/ops/terraform.nix
    ../../modules/ui/fonts.nix
  ];

  networking.hostName = "nixos-server";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  system.stateVersion = "25.05";

  # Home Manager (共通の home モジュールを使う場合)
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.steola = import ../../modules/home/home.nix;
  };
}

