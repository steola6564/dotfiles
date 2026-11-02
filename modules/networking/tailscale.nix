{ inputs, pkgs, ... }:

{
  services.tailscale = {
    enable = true;

    package = inputs.tailscale.packages.x86_64-linux.default;
  };
}
