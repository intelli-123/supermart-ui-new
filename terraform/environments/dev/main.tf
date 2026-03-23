provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source         = "../../modules/vpc"
  project_id     = var.project_id
  region         = var.region
  subnet_cidr    = "10.0.0.0/24"
  connector_cidr = "10.8.0.0/28"
}

module "database" {
  source        = "../../modules/database"
  project_id    = var.project_id
  region        = var.region
  vpc_self_link = module.vpc.vpc_self_link
  db_password   = var.db_password

  depends_on = [module.vpc]
}

module "compute" {
  source           = "../../modules/compute"
  project_id       = var.project_id
  region           = var.region
  image            = var.image
  vpc_connector_id = module.vpc.connector_id
  db_private_ip    = module.database.private_ip
  db_name          = module.database.db_name
  db_user          = module.database.db_user
  db_password      = var.db_password
  jwt_secret       = var.jwt_secret

  depends_on = [module.database]
}
