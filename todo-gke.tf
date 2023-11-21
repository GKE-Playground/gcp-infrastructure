resource "google_container_cluster" "todo_gke" {
  name     = "todo-gke"
  location = var.region
 
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
 
# Enabling Autopilot for this cluster
  enable_autopilot = true
}