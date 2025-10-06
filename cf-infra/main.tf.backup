terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  # STEP1 で export 済みの TF_VAR_cloudflare_api_token を拾います
  api_token = var.cloudflare_api_token
}

# ─────────────────────────────────────────────────────────────
# 1) DNS: terminal.niboratory.com -> <TunnelID>.cfargotunnel.com
# ─────────────────────────────────────────────────────────────
resource "cloudflare_record" "terminal" {
  zone_id = var.cloudflare_zone_id
  name    = "terminal"
  type    = "CNAME"
  content = "${var.tunnel_id}.cfargotunnel.com"
  proxied = true
  comment = "Managed by IaC: OpenTofu/Terraform"
}

# ─────────────────────────────────────────────────────────────
# 2) Access Application (SSH)
# ─────────────────────────────────────────────────────────────
resource "cloudflare_zero_trust_access_application" "terminal" {
  account_id       = var.cloudflare_account_id
  name             = "nixos-server-terminal"
  domain           = "terminal.niboratory.com"
  session_duration = "24h"
  type             = "ssh"

  # 注意: browser SSH を使うなら CF 側で Warp/BrowserSSH 経由になります。
  # (ここではアプリタイプのみ定義。細かいクライアント側は後続STEPで必要に応じて案内)
}

# ─────────────────────────────────────────────────────────────
# 3) Access Policy (自分のメールのみ許可)
# ─────────────────────────────────────────────────────────────
resource "cloudflare_zero_trust_access_policy" "terminal_allow_me" {
  account_id     = var.cloudflare_account_id
  application_id = cloudflare_zero_trust_access_application.terminal.id

  name       = "allow-myself"
  precedence = 1
  decision   = "allow"

  include {
    email = [ var.allow_email ]
  }
}

# 明示的にデフォルト deny を置きたい場合（任意）
resource "cloudflare_zero_trust_access_policy" "terminal_default_deny" {
  account_id     = var.cloudflare_account_id
  application_id = cloudflare_zero_trust_access_application.terminal.id

  name       = "default-deny"
  precedence = 1000
  decision   = "deny"

  include {
    everyone = true
  }
}

