variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "image" {
  description = "Full Docker image reference (e.g. gcr.io/project/image:tag)"
  type        = string
}

variable "vpc_connector_id" {
  description = "ID of the Serverless VPC Access Connector"
  type        = string
}

variable "db_private_ip" {
  description = "Private IP address of the Cloud SQL instance"
  type        = string
}

variable "db_name" {
  description = "Name of the MySQL database"
  type        = string
}

variable "db_user" {
  description = "MySQL application username"
  type        = string
}

variable "db_password" {
  description = "MySQL application user password"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT signing secret (hex-encoded)"
  type        = string
  sensitive   = true
}
