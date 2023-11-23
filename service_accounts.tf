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
  "principalSet://iam.googleapis.com/projects/507085571061/locations/global/workloadIdentityPools/terraform-pool-todo/attribute.repository/GKE-Playground/GET-ms",
  "principalSet://iam.googleapis.com/projects/507085571061/locations/global/workloadIdentityPools/terraform-pool-todo/attribute.repository/GKE-Playground/POST-ms",
  "principalSet://iam.googleapis.com/projects/507085571061/locations/global/workloadIdentityPools/terraform-pool-todo/attribute.repository/GKE-Playground/PUT-ms",
  "principalSet://iam.googleapis.com/projects/507085571061/locations/global/workloadIdentityPools/terraform-pool-todo/attribute.repository/GKE-Playground/todo-FE"]
}