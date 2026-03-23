output "vpc_id" {
  description = "The ID of the VPC network"
  value       = google_compute_network.test_supermart_vpc.id
}

output "vpc_self_link" {
  description = "The self-link of the VPC network (used for Cloud SQL private IP)"
  value       = google_compute_network.test_supermart_vpc.self_link
}

output "subnet_id" {
  description = "The ID of the primary subnet"
  value       = google_compute_subnetwork.test_supermart_subnet.id
}

output "connector_id" {
  description = "The ID of the Serverless VPC Access Connector"
  value       = google_vpc_access_connector.test_supermart_conn.id
}

output "psa_connection" {
  description = "The private services access connection (for Cloud SQL dependency)"
  value       = google_service_networking_connection.test_supermart_psa.network
}
