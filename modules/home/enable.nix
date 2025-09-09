# modules/home/enable.nix
{ lib, config, ... }:
let
  normalUsers = lib.filterAttrs (_: u: (u.isNormalUser or false)) config.users.users;
  userNames   = lib.attrNames normalUsers;
in
{
  assertions = [{
    assertion = lib.length userNames == 1;
    message   = "Home Manager auto-bind requires exactly one normal user.";
  }];

  # Home Manager 基本設定
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # 1人の通常ユーザーに自動でバインド
  home-manager.users.${lib.head userNames} = import ./home.nix;
}

