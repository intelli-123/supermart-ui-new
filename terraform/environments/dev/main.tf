provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source     = "../../modules/vpc"
  project_id = var.project_id
  region     = var.region
  subnet_cidr = "10.0.0.0/24"
}

module "database" {
  source      = "../../modules/database"
  project_id  = var.project_id
  region      = var.region
  db_password = var.db_password
}

module "compute" {
  source       = "../../modules/compute"
  project_id   = var.project_id
  region       = var.region
  image        = var.image
  db_public_ip = module.database.public_ip
  db_name      = module.database.db_name
  db_user      = module.database.db_user
  db_password  = var.db_password
  jwt_secret   = var.jwt_secret

  depends_on = [module.database]
}
