provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "github" {}

data "google_client_config" "default" {}
data "google_container_cluster" "my_cluster" {
  name     = "todo-gke"
  location = var.region
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.my_cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate)
}