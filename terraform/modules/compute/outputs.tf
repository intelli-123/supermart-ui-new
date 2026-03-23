output "cloud_run_url" {
  description = "Base URL of the deployed Cloud Run service"
  value       = google_cloud_run_v2_service.test_supermart_app.uri
}

output "swagger_ui_url" {
  description = "Swagger UI URL for the API"
  value       = "${google_cloud_run_v2_service.test_supermart_app.uri}/api/swagger-ui.html"
}

output "service_account_email" {
  description = "Email of the Cloud Run service account"
  value       = google_service_account.test_supermart_run_sa.email
}
