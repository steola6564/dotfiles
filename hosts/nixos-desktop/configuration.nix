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
    ../../modules/networking/wol.nix

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
    ../../modules/pkgs/gui.nix
    ../../modules/services/common.nix
    
    # Home Manager integration
    # If you prefer, you can also keep HM in the flake's 'homeConfigurations'.
    # Otherwise import this module to configure HM alongside the system.
    ../../modules/home-manager.nix
  ];

  networking.hostName = "nixos-desktop";
  boot.kernelPackages = pkgs.linuxPackages_6_6;
  # Keep this in system/base so all hosts can share a common baseline.
  system.stateVersion = "25.05"; # Do not change without reading the manual 
}

