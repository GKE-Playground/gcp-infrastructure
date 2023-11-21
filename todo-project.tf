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