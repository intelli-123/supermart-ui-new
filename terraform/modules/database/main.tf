resource "google_sql_database_instance" "test_supermart_db" {
  name                = "test-supermart-db-dev"
  database_version    = "MYSQL_8_0"
  region              = var.region
  project             = var.project_id
  deletion_protection = false

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_type         = "PD_SSD"
    disk_size         = 10

    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.vpc_self_link
      enable_private_path_for_google_cloud_services = true
    }

    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }

    database_flags {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  }
}

resource "google_sql_database" "test_supermartdb" {
  name     = "test-supermartdb"
  instance = google_sql_database_instance.test_supermart_db.name
  project  = var.project_id
  charset  = "utf8mb4"
}

resource "google_sql_user" "test_supermart_user" {
  name     = "test-supermart"
  instance = google_sql_database_instance.test_supermart_db.name
  password = var.db_password
  host     = "%"
  project  = var.project_id
}
