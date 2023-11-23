resource "google_container_cluster" "todo_gke" {
  name     = "todo-gke"
  location = var.region
 
  network    = google_compute_network.todo_vpc.name
  subnetwork = google_compute_subnetwork.todo_subnet.name
 
# Enabling Autopilot for this cluster
  enable_autopilot = true
}

resource "kubernetes_namespace" "todo_namespace" {
  metadata {
    name = "todo-namespace"
  }
}

resource "kubernetes_service_account" "todo_ksa" {
  metadata {
    name = "todo-ksa"

    namespace = kubernetes_namespace.todo_namespace.metadata[0].name
  }
}

module "my-app-workload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name                = "todo-sa"
  namespace           = kubernetes_namespace.todo_namespace.metadata[0].name
  project_id          = var.project_id
  roles               = ["roles/storage.admin", "roles/compute.admin","roles/cloudsql.client"]
}

resource "kubernetes_secret" "db_secret" {
  metadata {
    name = "tung-db-secret"
    namespace = kubernetes_namespace.todo_namespace.metadata[0].name
  }

  data = {
    username = base64encode("tung-user")
    password = base64encode("tung123")
    database = base64encode("todo-database")
  }

  type = "Opaque"  # You can adjust the secret type based on your use case
}