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
  password = var.postgres_tung_user_password
}

resource "google_sql_database" "todo_database" {
  name     = "todo-database"
  instance = google_sql_database_instance.todo_sql_public_instance.name
}
