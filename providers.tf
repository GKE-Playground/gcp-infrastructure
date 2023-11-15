provider "google" {
  credentials = var.tfc_gcp_dynamic_credentials.default.credentials
}