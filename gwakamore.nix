# Gwakamore.nix (simple)
{ lib, config, pkgs, ... }:
let
  cfg = config.services.gwakamore;
in {
  options.services.gwakamore = {
    enable = lib.mkEnableOption "Terminal-only Apache Guacamole via Cloudflared";

    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null; # 例: "guac.example.com"
      description = "Public hostname for Cloudflared (null to disable Cloudflared).";
    };

    # Cloudflared は credentialsFile か token のどちらか一方を渡す
    credentialsFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null; # 例: /var/lib/cloudflared/<TUNNEL_ID>.json
      description = "Path to Cloudflared tunnel credentials JSON.";
    };
    token = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null; # 例: "eyJ…"
      description = "Cloudflared token (alternative to credentialsFile).";
    };

    # Guacamole のユーザーマッピング（SSH 接続定義）
    userMapping = lib.mkOption {
      type = lib.types.path;
      default = /etc/nixos/guacamole/user-mapping.xml;
      description = "Path to guacamole user-mapping.xml (use sops/agenix in practice).";
    };

    # このマシンへ SSH するなら true（鍵認証想定）
    enableOpenSSH = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable OpenSSH on the host.";
    };
  };

  config = lib.mkIf cfg.enable {
    # SSH（必要な場合のみ）
    services.openssh = lib.mkIf cfg.enableOpenSSH {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      openFirewall = true;
    };

    # Guacamole（Web UI は :8080/guacamole）
    services.guacamole-server = {
      enable = true;
      host = "127.0.0.1";
      userMappingXml = cfg.userMapping;
    };
    services.guacamole-client = {
      enable = true;
      enableWebserver = true;
      settings = {
        guacd-hostname = "127.0.0.1";
        guacd-port     = 4822;
      };
    };

    # Cloudflared（domain が設定されている時だけ）
    services.cloudflared = lib.mkIf (cfg.domain != null) {
      enable = true;
      tunnels."gwac" =
        (lib.optionalAttrs (cfg.credentialsFile != null) { credentialsFile = cfg.credentialsFile; }) //
        (lib.optionalAttrs (cfg.token != null)           { token           = cfg.token; }) //
        {
          ingress = [
            { hostname = cfg.domain; service = "http://127.0.0.1:8080/guacamole"; }
            { service = "http_status:404"; }
          ];
        };
    };

    # 最低限の検証
    assertions = [
      {
        assertion = (cfg.domain == null) || (cfg.credentialsFile != null || cfg.token != null);
        message = "When services.gwakamore.domain is set, provide credentialsFile or token.";
      }
    ];
  };
}

