# VPC network (retained for future private connectivity / NAT if needed)
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
