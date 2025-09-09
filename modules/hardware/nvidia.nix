{ config, lib, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # Wayland/NVIDIA interop knobs
  environment.sessionVariables = {
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "GBM_BACKEND" = "nvidia-drm";
    "WLR_NO_HARDWARE_CURSORS" = "1";
  };
}
