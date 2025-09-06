{ pkgs, ... }: {
  programs.mtr.enable = true;
  environment.systemPackages = with pkgs; [
    vim wget neovim git htop curl cloudflared-bin terraform opentofu
  ];
}

