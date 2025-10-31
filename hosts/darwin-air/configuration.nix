{ config, pkgs, ... }:
{
  # 必須：新規インストールの基準値（今は 6）
  system.stateVersion = 6;

  # nix を有効化（有効なら nix-daemon も自動管理される）
  nix.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # 最近の変更でnix.enable = true;のみで良くなった
  # services.nix-daemon.enable = true;

  system.primaryUser = "steola";

  users.users.steola.home = "/Users/steola";
  imports = [ 
    ../../modules/home-manager.nix
    ../../modules/pkgs/common.nix
    ../../modules/ops/agenix.nix
    ../../modules/darwin/system.nix
    ../../modules/darwin/brew.nix
    ../../modules/darwin/mas.nix
    ../../modules/darwin/display.nix
    ../../modules/darwin/maintenance.nix
  ];
}

