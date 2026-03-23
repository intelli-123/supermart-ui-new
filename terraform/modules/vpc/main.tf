resource "google_compute_network" "test_supermart_vpc" {
  name                    = "test-supermart-vpc"
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "test_supermart_subnet" {
  name          = "test-supermart-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.test_supermart_vpc.id
  project       = var.project_id
}

# Private Services Access — required for Cloud SQL private IP
resource "google_compute_global_address" "test_supermart_psa_range" {
  name          = "test-supermart-psa-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.test_supermart_vpc.id
  project       = var.project_id
}

resource "google_service_networking_connection" "test_supermart_psa" {
  network                 = google_compute_network.test_supermart_vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.test_supermart_psa_range.name]
}

# Serverless VPC Access Connector — enables Cloud Run → VPC egress
resource "google_vpc_access_connector" "test_supermart_conn" {
  name          = "test-supermart-conn"
  region        = var.region
  network       = google_compute_network.test_supermart_vpc.id
  ip_cidr_range = var.connector_cidr
  project       = var.project_id

  depends_on = [google_compute_subnetwork.test_supermart_subnet]
}
