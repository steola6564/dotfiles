{ pkgs, ... }:
{
  users.groups.cloudflared = {};
  users.users.cloudflared = {
    isSystemUser = true;
    group        = "cloudflared";
    description  = "Cloudflared Service user";
  };

  console.keyMap = "jp106";

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication       = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin              = "no";
    };
  };
}

