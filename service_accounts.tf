resource "google_service_account" "service_account" {
  account_id   = "github-actions-tung"
  display_name = "github-actions-tung"
}

resource "google_project_iam_member" "gcr_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_iam_member" "gke_admin" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_iam_member" "storage_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_iam_member" "wif_user" {
  project = var.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_iam_member" "cloud_sql_admin" {
  project = var.project_id
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:${google_service_account.service_account.email}"
}


resource "google_service_account" "todo_gsa" {
  account_id   = "todo-gsa"
  display_name = "todo-gsa"
}

resource "google_project_iam_member" "todo_sql_client_role" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.todo_gsa.email}"
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