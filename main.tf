terraform {
  cloud {
    organization = "TFC-Practice"

    hostname = "app.terraform.io"

    workspaces {
      name = "gcp-infrastructure"
    }
  }

  required_providers {
    github = {
      source = "integrations/github"
    }

    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }

  required_version = ">= 0.14"
}