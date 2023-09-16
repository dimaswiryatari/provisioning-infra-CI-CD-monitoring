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
  project = "portofolio-397818" 
  region = "asia-southeast1"
  zone = "asia-southeast1-b"  
  credentials = "/home/oem/Documents/CI-CD/credential-provisioning.json"
}

resource "google_compute_instance" "master-agent" {
  name         = "jenkins-master"
  machine_type = "e2-medium"

  tags = ["jenkins"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"
    subnetwork = "default"
    access_config {
      // Ephemeral public IP
    }
  }

}

resource "google_compute_instance" "node-agent" {
  name         = "jenkins-node"
  machine_type = "e2-medium"

  tags = ["jenkins"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = "default"
    subnetwork = "default"
    access_config {
      // Ephemeral public IP
    }
  }

}


resource "google_compute_firewall" "default" {
  name = "jenkins-network"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow{
    protocol = "tcp"
    ports = ["8080"]
  }

  source_tags = ["jenkins"]
  target_tags = [ "jenkins" ]

  source_ranges = [ "0.0.0.0/0" ]
}

output "public_ip-master" {
  value = google_compute_instance.master-agent.network_interface.0.access_config.0.nat_ip
}

output "public_ip-agent" {
  value = google_compute_instance.node-agent.network_interface.0.access_config.0.nat_ip
}