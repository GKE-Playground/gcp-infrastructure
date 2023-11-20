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

resource "google_sql_table" "example_table" {
  name     = "example-table"
  database = google_sql_database.postgres_sql_database.name
  instance = google_sql_database_instance.postgres_sql_instance.name

  column {
    name = "id"
    type = "SERIAL"
    constraints = ["PRIMARY KEY"]
  }

  column {
    name = "name"
    type = "VARCHAR(255)"
  }

  column {
    name = "age"
    type = "INT"
  }
}