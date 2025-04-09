terraform {
  required_providers {
    cloudsigma = {
      source = "cloudsigma/cloudsigma"
    }
  }
}

provider "cloudsigma" {
  # Credentials would be provided via environment variables in a real scenario
}

module "database" {
  source = "../../modules/database"
  
  name        = "test-postgresql-db"
  environment = "dev"
  vpc_id      = "vpc-12345"
  subnet_ids  = ["subnet-1", "subnet-2"]
  vpc_cidr    = "10.0.0.0/16"
  db_password = "test-password"
  os_image_uuid = "ubuntu-20.04"
  
  tags = {
    Project     = "BrainIncubator"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
