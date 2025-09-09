# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ 
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    
    # System
    ../../modules/system/base.nix
    ../../modules/system/boot.nix

    # Networking
    ../../modules/networking/common.nix

    # UI & Desktop
    ../../modules/ui/fonts.nix
    ../../modules/ui/desktop.nix

    # Input/Locale
    ../../modules/i18n/input.nix

    # Hardware
    ../../modules/hardware/nvidia.nix

    # Audio
    ../../modules/audio/pipewire.nix

    # Users
    ../../modules/users/steola.nix

    # Packages & Services
    ../../modules/pkgs/common.nix
    ../../modules/services/common.nix
    
    # Home Manager integration
    # If you prefer, you can also keep HM in the flake's 'homeConfigurations'.
    # Otherwise import this module to configure HM alongside the system.
    # ../../modules/home-manager.nix
  ];

  networking.hostName = "nixos-desktop";

  system.stateVersion = "25.05"; # Did you read the comment?

  home-manager = {
    ## Home Manager（flake 側でモジュールを読み込み済み）
    useGlobalPkgs = true;
    useUserPackages = true;

    # ← ここが大事：サブモジュールとして“imports”に渡す
    users.steola = import ../../modules/home/home.nix;
  };
}

