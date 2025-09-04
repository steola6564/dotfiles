variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with DNS:Edit, Access:Edit (Account-scoped), and (optional) Tunnel:Read"
  sensitive   = true
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Zone ID for niboratory.com"
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare Account ID (from credentials.json AccountTag)"
}

variable "tunnel_id" {
  type        = string
  description = "Existing Cloudflare Tunnel UUID (from credentials.json TunnelID)"
}

variable "allow_email" {
  type        = string
  description = "Email address allowed by Access"
}

