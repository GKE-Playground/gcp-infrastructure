resource "google_sql_database_instance" "sql-instance-psa" {
  name             = "tung-sql-instance-psa"
  region           = var.region
  database_version = "MYSQL_8_0"

  depends_on = [google_service_networking_connection.default]

  settings {
    tier = "db-custom-2-7680"
    ip_configuration { 
      ipv4_enabled    = "false"
      private_network = "projects/${var.project_id}/global/networks/${module.vpc-sql-module.network_name}"
    }
  }
  deletion_protection = false
}