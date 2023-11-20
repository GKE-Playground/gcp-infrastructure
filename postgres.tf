resource "google_sql_database_instance" "postgres_sql_instance" {
  name             = "tung-postgres-sql-instance"
  region           = var.region
  database_version = "POSTGRES_12"

  settings {
    tier = "db-custom-2-7680"
  }
  deletion_protection = false

  provisioner "local-exec" {
    command = "PGPASSWORD=tung123 psql -h ${google_sql_database_instance.default.ip_address} -p 5432 -U tung-user -d tung-database -f schema.sql"
  }
}

resource "google_sql_user" "users" {
  name     = "tung-user"
  instance = google_sql_database_instance.postgres_sql_instance.name
  password = "tung123"
}

resource "google_sql_database" "postgres_sql_database" {
  name     = "tung-database"
  instance = google_sql_database_instance.postgres_sql_instance.name
}
