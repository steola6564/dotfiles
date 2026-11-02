{ inputs, pkgs, ... }:

{
  services.tailscale = {
    enable = true;

    package = (
      builtins.getAttr
        pkgs.stdenv.hostPlatform.system
        inputs.tailscale.packages
    ).default;
  };
}
