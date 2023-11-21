# VPC
resource "google_compute_network" "todo_vpc" {
  name                    = "todo-vpc"
  auto_create_subnetworks = "false"
  mtu                     = 1460
  project                 = var.project_id
}

# Subnet
resource "google_compute_subnetwork" "todo_subnet" {
  name          = "todo-subnet"
  region        = var.region
  network       = google_compute_network.todo_vpc.name
  ip_cidr_range = "10.10.10.0/24"
  project       = var.project_id
}

resource "google_container_cluster" "todo_gke" {
  name     = "todo-gke"
  location = var.region
 
  network    = google_compute_network.todo_vpc.name
  subnetwork = google_compute_subnetwork.todo_subnet.name
 
# Enabling Autopilot for this cluster
  enable_autopilot = true
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
