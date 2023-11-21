provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "github" {}

provider "kubernetes" {
  host                   = "34.141.163.114"
  cluster_ca_certificate = base64decode(google_container_cluster.todo_gke.master_auth.0.cluster_ca_certificate)
}
