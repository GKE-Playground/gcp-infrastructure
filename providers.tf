provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "github" {}

provider "kubernetes" {
  host                   = google_container_cluster.todo_gke.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.todo_gke.master_auth.0.cluster_ca_certificate)
}
