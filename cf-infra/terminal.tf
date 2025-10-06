resource "cloudflare_record" "terminal" {
  zone_id = var.cloudflare_zone_id
  name    = "terminal"
  type    = "CNAME"
  content = "${var.tunnel_id}.cfargotunnel.com"
  proxied = true
  comment = "Terminal via Cloudflare Tunnel"
}

resource "cloudflare_zero_trust_access_application" "terminal" {
  account_id       = var.cloudflare_account_id
  name             = "terminal"
  domain           = "terminal.niboratory.com"
  session_duration = "24h"
  type             = "ssh"
}

resource "cloudflare_zero_trust_access_policy" "terminal_allow_me" {
  account_id     = var.cloudflare_account_id
  application_id = cloudflare_zero_trust_access_application.terminal.id
  name           = "allow-myself"
  precedence     = 1
  decision       = "allow"

  include {
    email = [ var.allow_email ]
  }
}

resource "cloudflare_zero_trust_access_policy" "terminal_default_deny" {
  account_id     = var.cloudflare_account_id
  application_id = cloudflare_zero_trust_access_application.terminal.id
  name           = "default-deny"
  precedence     = 1000          # 大きい数 = 一番下で評価
  decision       = "deny"

  include {
    everyone = true              # だれでも(=全件)を明示的にdeny
  }
}

