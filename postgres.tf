resource "google_sql_database_instance" "sql_instance" {
  name             = "tung-sql-instance"
  region           = var.region
  database_version = "POSTGRES_12"

  settings {
    tier = "db-custom-2-7680"
  }
  deletion_protection = false
}