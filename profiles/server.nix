{ pkgs, ... }:
{
  users.groups.cloudflared = {};
  users.users.cloudflared = {
    isSystemUser = true;
    group        = "cloudflared";
    description  = "Cloudflared Service user";
  };


  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication       = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin              = "no";
    };
  };
}

