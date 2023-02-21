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
      version = "3.35.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
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
