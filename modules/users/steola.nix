{ config, lib, pkgs, ... }:
{
  users.users.steola = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [ tree bat ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
