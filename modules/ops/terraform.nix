{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    jq
    (pkgs.writeShellScriptBin "tf" ''
      set -euo pipefail
      cfg='${config.age.secrets."tf/cloudflare.json".path}'
      export TF_VAR_cloudflare_api_token="$(jq -r .api_token "$cfg")"
      export TF_VAR_cloudflare_zone_id="$(jq -r .zone_id "$cfg")"
      export TF_VAR_cloudflare_account_id="$(jq -r .account_id "$cfg")"
      export TF_VAR_tunnel_id="$(jq -r .tunnel_id "$cfg")"
      export TF_VAR_allow_email="$(jq -r .allow_email "$cfg")"
      exec ${pkgs.terraform}/bin/terraform "$@"
    '')
  ];
}

