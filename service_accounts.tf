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

resource "google_service_account_iam_binding" "sa_iam_binding_wif" {
  service_account_id = google_service_account.service_account.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principal://iam.googleapis.com/projects/${var.PROJECT_NUMBER}/locations/global/workloadIdentityPools/terraform-pool-todo/providers/github-provider-todo",
  ]
}