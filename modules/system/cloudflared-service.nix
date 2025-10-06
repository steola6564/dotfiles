{ config, pkgs, ... }: {
  # 自動更新抑止：既存 unit 名をそのまま維持
  systemd.services."cloudflared-tunnel-e34c4c53-0d57-44fc-a32d-62afedbe5c05".serviceConfig = {
    Environment = "CLOUDFLARED_NO_AUTOUPDATE=true";
  };

  services.cloudflared = {
    enable  = true;
    package = pkgs.cloudflared-bin;

    tunnels."e34c4c53-0d57-44fc-a32d-62afedbe5c05" = {
      credentialsFile = config.age.secrets."cloudflared/credentials".path;

      ingress = {
        "terminal.niboratory.com" = "ssh://localhost:22";
	"cloud.niboratory.com" = "http://127.0.0.1:8080";
        # "terminal.niboratory.com" = { service = "http://127.0.0.1:8000"; };
      };
      default = "http_status:404";
    };
  };
}

