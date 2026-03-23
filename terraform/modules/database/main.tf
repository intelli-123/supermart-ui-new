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
      # Public IP — Cloud Run connects directly over SSL (dev environment)
      ipv4_enabled = true

      authorized_networks {
        name  = "allow-all-dev"
        value = "0.0.0.0/0"
      }
    }

    backup_configuration {
      enabled = true
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
