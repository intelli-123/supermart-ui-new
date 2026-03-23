variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "proven-country-485607-p6"
}

variable "region" {
  description = "GCP deployment region"
  type        = string
  default     = "us-central1"
}

variable "image" {
  description = "Full Docker image reference (gcr.io/project/image:tag)"
  type        = string
}

variable "db_password" {
  description = "Cloud SQL MySQL application user password"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "JWT signing secret (hex-encoded, minimum 64 hex chars)"
  type        = string
  sensitive   = true
}
