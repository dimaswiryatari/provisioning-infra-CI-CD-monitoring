remote_state {
    backend = "gcs"
    config = {
      bucket = "<bucket-name>"
      prefix = "${path_relative_to_include()}/terraform.tfstate"
      credentials = "<credentials-path>"
    }
}

inputs = {
  project = "<project-id>"
  region = "asia-southeast2"
  zone = "asia-southeast2-a"
  credentials = "<credentials-path>"

  name = "${basename(get_terragrunt_dir())}"
  machine_type = "e2-small"
  image = "ubuntu-os-cloud/ubuntu-2004-lts"
}