terraform {

  cloud {
    organization = "benwal-io"

    workspaces {
      name = "home-ops-cloudflare"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.0.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
  }
}

data "sops_file" "cloudflare_secrets" {
  source_file = "secret.sops.yaml"
}
