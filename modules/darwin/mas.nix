# modules/darwin/mas.nix
{ config, pkgs, ... }:
{
  homebrew = {
    enable = true;

    # mas CLI 自体
    brews = [ "mas" ];

    # App Store アプリを declarative に管理したい場合はこちらに追加
    masApps = {
      LINE = 539883307;
      UpNote = 1398373917;
    };
  };
}

