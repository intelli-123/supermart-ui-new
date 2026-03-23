# Service account that the Cloud Run service runs as
resource "google_service_account" "test_supermart_run_sa" {
  account_id   = "test-supermart-run-sa"
  display_name = "Test Supermart Cloud Run SA"
  project      = var.project_id
}

resource "google_project_iam_member" "test_supermart_run_sa_sql" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.test_supermart_run_sa.email}"
}

resource "google_project_iam_member" "test_supermart_run_sa_logs" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.test_supermart_run_sa.email}"
}

resource "google_project_iam_member" "test_supermart_run_sa_metrics" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.test_supermart_run_sa.email}"
}

resource "google_cloud_run_v2_service" "test_supermart_app" {
  name                = "test-svc-supermart-dev"
  location            = var.region
  project             = var.project_id
  deletion_protection = false

  template {
    service_account = google_service_account.test_supermart_run_sa.email

    # Route all egress through VPC to reach Cloud SQL private IP
    vpc_access {
      connector = var.vpc_connector_id
      egress    = "ALL_TRAFFIC"
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 3
    }

    containers {
      image = var.image

      ports {
        container_port = 8080
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
        cpu_idle = true
      }

      env {
        name  = "SPRING_PROFILES_ACTIVE"
        value = "docker"
      }

      env {
        name  = "SPRING_DATASOURCE_URL"
        value = "jdbc:mysql://${var.db_private_ip}:3306/${var.db_name}?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
      }

      env {
        name  = "SPRING_DATASOURCE_USERNAME"
        value = var.db_user
      }

      env {
        name  = "SPRING_DATASOURCE_PASSWORD"
        value = var.db_password
      }

      env {
        name  = "SPRING_JPA_HIBERNATE_DDL_AUTO"
        value = "none"
      }

      env {
        name  = "APP_JWT_SECRET"
        value = var.jwt_secret
      }

      env {
        name  = "APP_JWT_ACCESS_TOKEN_EXPIRATION_MS"
        value = "3600000"
      }

      env {
        name  = "APP_JWT_REFRESH_TOKEN_EXPIRATION_MS"
        value = "86400000"
      }

      env {
        name  = "APP_TELEMETRY_RATE_LIMIT_PER_MINUTE"
        value = "2"
      }

      startup_probe {
        http_get {
          path = "/api/actuator/health"
          port = 8080
        }
        initial_delay_seconds = 30
        period_seconds        = 10
        failure_threshold     = 5
        timeout_seconds       = 5
      }

      liveness_probe {
        http_get {
          path = "/api/actuator/health"
          port = 8080
        }
        period_seconds    = 30
        failure_threshold = 3
        timeout_seconds   = 5
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "test_supermart_public_invoker" {
  project  = var.project_id
  location = var.region
  name     = google_cloud_run_v2_service.test_supermart_app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
