provider "google" {
  credentials = var.tfc_gcp_dynamic_credentials.default.credentials
}

provider "google" {
  alias = "ALIAS1"
  credentials = var.tfc_gcp_dynamic_credentials.aliases["ALIAS1"].credentials
}