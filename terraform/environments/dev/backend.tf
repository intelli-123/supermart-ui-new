terraform {
  required_version = ">= 1.7.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "tfstate-test-supermart-dev"
    prefix = "terraform/state"
  }
}
