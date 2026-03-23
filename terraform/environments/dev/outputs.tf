output "cloud_run_url" {
  description = "Base URL of the Cloud Run service"
  value       = module.compute.cloud_run_url
}

output "swagger_ui_url" {
  description = "Swagger UI endpoint"
  value       = module.compute.swagger_ui_url
}

output "cloud_sql_connection_name" {
  description = "Cloud SQL connection name for reference"
  value       = module.database.connection_name
}
