{ config, pkgs, ... }:
{
  # 必須：新規インストールの基準値（今は 6）
  system.stateVersion = 6;

  # nix を有効化（有効なら nix-daemon も自動管理される）
  nix.enable = true;

  # ルート側も flakes/nix-command を宣言的にON（おすすめ）
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # programs.zsh.enable = true;
  # nixpkgs.config.allowUnfree = true;

  # services.nix-daemon.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    # curl
    # vim
  ];
}

