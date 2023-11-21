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

resource "google_sql_database_instance" "todo_sql_public_instance" {
  name             = "todo-sql-public-instance"
  region           = var.region
  database_version = "POSTGRES_12"

  settings {
    tier = "db-custom-2-7680"
  }
  deletion_protection = false
}

resource "google_sql_user" "todo_users" {
  name     = "tung-user"
  instance = google_sql_database_instance.todo_sql_public_instance.name
  password = "tung123"
}

resource "google_sql_database" "todo_database" {
  name     = "todo-database"
  instance = google_sql_database_instance.todo_sql_public_instance.name
}


resource "kubernetes_namespace" "todo_namespace" {
  metadata {
    name = "todo-namespace"
  }
}

resource "kubernetes_service_account" "todo_ksa" {
  metadata {
    name = "todo-ksa"

    namespace = kubernetes_namespace.todo_namespace.metadata[0].name
  }
}

resource "google_project_iam_member" "service_account_binding" {
  project = var.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${var.project_id}.svc.id.goog[${kubernetes_namespace.todo_namespace.metadata[0].name}/${kubernetes_service_account.todo_ksa.metadata[0].name}]/${google_service_account.todo_gsa.account_id}@${var.project_id}.iam.gserviceaccount.com"
}