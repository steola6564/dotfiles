resource "cloudflare_record" "nextcloud" {
  zone_id = var.cloudflare_zone_id
  name    = "cloud"
  type    = "CNAME"
  content = "${var.tunnel_id}.cfargotunnel.com"
  proxied = true
  comment = "Nextcloud via Cloudflare Tunnel"
}

resource "cloudflare_zero_trust_access_application" "nextcloud" {
  account_id       = var.cloudflare_account_id
  name             = "nextcloud"
  domain           = "cloud.niboratory.com"
  session_duration = "24h"
  type             = "self_hosted"
}

resource "cloudflare_zero_trust_access_policy" "nextcloud_allow_me" {
  account_id     = var.cloudflare_account_id
  application_id = cloudflare_zero_trust_access_application.nextcloud.id
  name           = "allow-myself"
  precedence     = 1
  decision       = "allow"

  include {
    email = [ var.allow_email ]
  }
}

resource "cloudflare_zero_trust_access_policy" "nextcloud_default_deny" {
  account_id     = var.cloudflare_account_id
  application_id = cloudflare_zero_trust_access_application.nextcloud.id
  name           = "default-deny"
  precedence     = 1000
  decision       = "deny"

  include {
    everyone = true
  }
}

