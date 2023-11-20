resource "google_sql_database_instance" "postgres_sql_instance" {
  name             = "tung-postgres-sql-instance"
  region           = var.region
  database_version = "POSTGRES_12"

  settings {
    tier = "db-custom-2-7680"
  }
  deletion_protection = false
}

resource "google_sql_user" "users" {
  name     = "me"
  instance = google_sql_database_instance.postgres_sql_instance.name
  host     = "me.com"
  password = "tung123"
}