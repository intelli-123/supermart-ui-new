variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "vpc_self_link" {
  description = "Self-link of the VPC network for private IP configuration"
  type        = string
}

variable "db_password" {
  description = "Password for the MySQL application user"
  type        = string
  sensitive   = true
}
