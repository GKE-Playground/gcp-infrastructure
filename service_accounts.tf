resource "google_service_account" "service_account" {
  account_id   = "github-actions-tung"
  display_name = "github-actions-tung"
}

variable "iam_roles" {
  type = map(string)
  default = {
    gcr_writer      = "roles/artifactregistry.writer",
    gke_admin       = "roles/container.admin",
    storage_admin   = "roles/storage.admin",
    wif_user        = "roles/iam.workloadIdentityUser",
    cloud_sql_admin = "roles/cloudsql.admin",
  }
}

resource "google_project_iam_member" "iam_members" {
  for_each = var.iam_roles

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

module "my-app-workload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name                = "todo-sa"
  namespace           = kubernetes_namespace.todo_namespace.metadata[0].name
  project_id          = var.project_id
  roles               = ["roles/storage.admin", "roles/compute.admin","roles/cloudsql.client"]
}