output "vpc_id" {
  description = "The ID of the VPC network"
  value       = google_compute_network.test_supermart_vpc.id
}

output "vpc_self_link" {
  description = "The self-link of the VPC network"
  value       = google_compute_network.test_supermart_vpc.self_link
}

output "subnet_id" {
  description = "The ID of the primary subnet"
  value       = google_compute_subnetwork.test_supermart_subnet.id
}
