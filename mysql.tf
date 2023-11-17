resource "google_sql_database_instance" "sql-instance-psa" {
  name             = "tung-sql-instance-psa"
  region           = var.region
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-custom-2-7680"
  }
  deletion_protection = false
}