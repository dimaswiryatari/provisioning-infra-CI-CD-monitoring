terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.77.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "project-id" 
  region = "asia-southeast2"
  zone = "asia-southeast2-a"  
  credentials = "credential-provisioning.json"
}


resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "asia-southeast2-a"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 4

   node_config {
    disk_size_gb = 15
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "asia-southeast2-a"
  cluster    = google_container_cluster.primary.name
  node_count = 4

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    disk_size_gb = "15"
  }
}