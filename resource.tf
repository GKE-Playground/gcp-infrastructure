resource "google_storage_bucket" "TFC-Senacor-first-bucket" {
  name          = "tung-senacor-first-bucket"
  location      = "EU"
  storage_class = "STANDARD"
  project       = var.project_id
}
