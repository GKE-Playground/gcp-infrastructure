resource "google_sql_database_instance" "quickstart_postgres_sql_instance" {
  name             = "quickstart-instance"
  region           = var.zone
  database_version = "POSTGRES_12"

  settings {
    tier = "db-custom-2-7680"
  }
  deletion_protection = false
}

resource "google_sql_user" "users" {
  name     = "quickstart-db-user"
  instance = google_sql_database_instance.quickstart_postgres_sql_instance_postgres_sql_instance.name
  password = "tung123"
}