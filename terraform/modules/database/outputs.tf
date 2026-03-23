output "connection_name" {
  description = "Cloud SQL connection name (project:region:instance)"
  value       = google_sql_database_instance.test_supermart_db.connection_name
}

output "private_ip" {
  description = "Private IP address of the Cloud SQL instance"
  value       = google_sql_database_instance.test_supermart_db.private_ip_address
}

output "db_name" {
  description = "Name of the MySQL database"
  value       = google_sql_database.test_supermartdb.name
}

output "db_user" {
  description = "MySQL application username"
  value       = google_sql_user.test_supermart_user.name
}
