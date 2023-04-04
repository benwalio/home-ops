
data "cloudflare_zones" "domain" {
  filter {
    name = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  }
}

resource "cloudflare_zone_settings_override" "cloudflare_settings" {
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  settings {
    ssl                      = "strict"
    always_use_https         = "on"
    min_tls_version          = "1.2"
    opportunistic_encryption = "on"
    tls_1_3                  = "zrt"
    automatic_https_rewrites = "on"
    universal_ssl            = "on"
    browser_check            = "on"
    challenge_ttl            = 1800
    privacy_pass             = "on"
    security_level           = "medium"
    brotli                   = "on"
    minify {
      css  = "on"
      js   = "on"
      html = "on"
    }
    rocket_loader       = "on"
    always_online       = "off"
    development_mode    = "off"
    http3               = "on"
    zero_rtt            = "on"
    ipv6                = "on"
    websockets          = "on"
    opportunistic_onion = "on"
    pseudo_ipv4         = "off"
    ip_geolocation      = "on"
    email_obfuscation   = "on"
    server_side_exclude = "on"
    hotlink_protection  = "off"
    security_header {
      enabled = false
    }
  }
}

data "http" "ipv4" {
  url = "http://ipv4.icanhazip.com"
}

resource "cloudflare_record" "ipv4" {
  name    = "ipv4"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = chomp(data.http.ipv4.response_body)
  proxied = true
  type    = "A"
  ttl     = 1
}

resource "cloudflare_record" "root" {
  name    = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "ipv4.${data.sops_file.cloudflare_secrets.data["cloudflare_domain"]}"
  proxied = true
  type    = "CNAME"
  ttl     = 1
}


resource "cloudflare_record" "email_domain_simplelogin_cname1" {
  name    = "dkim._domainkey"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "dkim._domainkey.simplelogin.co"
  proxied = false
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "email_domain_simplelogin_cname2" {
  name    = "dkim02._domainkey"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "dkim02._domainkey.simplelogin.co"
  proxied = false
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "email_domain_simplelogin_cname3" {
  name    = "dkim03._domainkey"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "dkim03._domainkey.simplelogin.co"
  proxied = false
  type    = "CNAME"
  ttl     = 1
}


resource "cloudflare_record" "email_domain_simplelogin_mx1" {
  name     = "benwal.casa"
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value    = "mx1.simplelogin.co"
  proxied  = false
  type     = "MX"
  ttl      = 1
  priority = 10
}

resource "cloudflare_record" "email_domain_simplelogin_mx2" {
  name     = "benwal.casa"
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value    = "mx2.simplelogin.co"
  proxied  = false
  type     = "MX"
  ttl      = 1
  priority = 20
}

resource "cloudflare_record" "email_domain_simplelogin_spf" {
  name    = "benwal.casa"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "v=spf1 include:simplelogin.co ~all"
  proxied = false
  type    = "TXT"
  ttl     = 1
}

resource "cloudflare_record" "email_domain_simplelogin_verify" {
  name    = "benwal.casa"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "sl-verification=ckrkbwmpugmrolvmrsqkdycqqjhwye"
  proxied = false
  type    = "TXT"
  ttl     = 1
}

resource "cloudflare_record" "email_domain_simplelogin_dmarc" {
  name    = "_dmarc"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "v=DMARC1; p=quarantine; pct=100; adkim=s; aspf=s"
  proxied = false
  type    = "TXT"
  ttl     = 1
}

resource "cloudflare_page_rule" "domain_plex_bypass" {
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  target   = "https://plex.benwal.casa./*"
  status   = "active"
  priority = 1

  actions {
    cache_level              = "bypass"
    rocket_loader            = "off"
    automatic_https_rewrites = "on"
  }
}

resource "cloudflare_page_rule" "domain_home_assistant_bypass" {
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  target   = "https://hass.benwal.casa./*"
  status   = "active"
  priority = 2

  actions {
    cache_level              = "bypass"
    rocket_loader            = "off"
    automatic_https_rewrites = "on"
  }
}

resource "cloudflare_page_rule" "domain_photos_bypass" {
  zone_id  = lookup(data.cloudflare_zones.domain.zones[0], "id")
  target   = "https://photos.benwal.casa./*"
  status   = "active"
  priority = 3

  actions {
    cache_level              = "bypass"
    rocket_loader            = "off"
    automatic_https_rewrites = "on"
  }
}
