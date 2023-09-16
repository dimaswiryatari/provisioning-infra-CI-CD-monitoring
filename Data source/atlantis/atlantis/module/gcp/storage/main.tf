terraform {
  backend "gcs" {}
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.74.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = var.project
  region = var.region
  zone = var.zone
  credentials = var.credentials
}

resource "google_storage_bucket" "default" {
  name = var.name
  location = var.location
  force_destroy = true
}