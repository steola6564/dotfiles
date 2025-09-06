{ pkgs, ... }: {
  users.users.steola = {
    isNormalUser = true;
    extraGroups  = [ "wheel" ];
    packages     = with pkgs; [ tree bat ];
    shell        = pkgs.zsh;
  };

  users.groups.cloudflared = {};
  users.users.cloudflared = {
    isSystemUser = true;
    group        = "cloudflared";
    description  = "Cloudflared Service user";
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}

