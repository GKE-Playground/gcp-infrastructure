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
  name     = "tung-user"
  instance = google_sql_database_instance.postgres_sql_instance.name
  password = "tung123"
}

resource "google_sql_database" "postgres_sql_database" {
  name     = "tung-database"
  instance = google_sql_database_instance.postgres_sql_instance.name
}

resource "null_resource" "create_table" {
  depends_on = [google_sql_database.postgres_sql_database]

  provisioner "local-exec" {
    command = <<EOT
      gcloud sql databases execute \
      --project=${var.project_id} \
      --instance=${google_sql_database_instance.postgres_sql_instance.name} \
      --database=${google_sql_database.postgres_sql_database.name} \
      --sql='CREATE TABLE IF NOT EXISTS your_table_name (id SERIAL PRIMARY KEY, name VARCHAR(255), age INT);'
    EOT
  }
}