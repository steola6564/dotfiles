# modules/darwin/mas.nix
{ config, pkgs, ... }:
{
  homebrew = {
    enable = true;

    # mas CLI 自体
    brews = [ "mas" ];

    # App Store アプリを declarative に管理したい場合はこちらに追加
    masApps = {
      # Slack = 803453959;
      # LINE = 539883307;
    };
  };
}

