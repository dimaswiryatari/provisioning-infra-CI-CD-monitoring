terraform {
    source = "../../../..//module/gcp/instance"
}

include {
    path = find_in_parent_folders()
}

inputs = {
    tags = ["http-server"]
    network = "default"
    subnetwork = "default"

}
