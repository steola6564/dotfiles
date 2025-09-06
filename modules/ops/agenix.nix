{ config, pkgs, inputs, ... }: {
  imports = [ inputs.agenix.nixosModules.default ];

  # 起動時に使う秘密鍵
  age.identityPaths = [ "/etc/age/host.agekey" ];

  # agenix/age のバイナリ（CLI）
  environment.systemPackages = [
    pkgs.age
    inputs.agenix.packages.${pkgs.system}.default
  ];

  # 復号ファイル（所有者/権限を現行通り）
  age.secrets."cloudflared/credentials" = {
    file  = ./../../secrets/cloudflared-credentials.age;
    owner = "cloudflared";
    group = "cloudflared";
    mode  = "0400";
  };

  age.secrets."tf/cloudflare.json" = {
    file  = ./../../secrets/tf-cloudflare.json.age;
    owner = "steola";
    group = "users";
    mode  = "0400";
  };
}

