{ config, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud30;
    hostName = "cloud.niboratory.com";
    https = true;                   # Cloudflare側でTLS終端
    nginx.enableACME = false;       # Let's Encrypt不要（CloudflareでProxy化）
    maxUploadSize = "10G";
    config = {
      adminuser = "admin";
      adminpassFile = "/var/lib/nextcloud/admin-pass";
    };
    datadir = "/var/lib/nextcloud/data";
  };

  services.nginx.enable = true;

  # Cloudflareトンネル経由アクセス向けヘッダ設定を安全にする
  services.nginx.virtualHosts."cloud.niboratory.com" = {
    forceSSL = true;
    enableACME = false;
    extraConfig = ''
      set_real_ip_from 103.21.244.0/22;
      set_real_ip_from 103.22.200.0/22;
      set_real_ip_from 103.31.4.0/22;
      set_real_ip_from 141.101.64.0/18;
      set_real_ip_from 108.162.192.0/18;
      real_ip_header CF-Connecting-IP;
    '';
  };
}

