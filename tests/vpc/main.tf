terraform {
  required_providers {
    cloudsigma = {
      source = "cloudsigma/cloudsigma"
    }
  }
}

provider "cloudsigma" {
  # Credentials would be provided via environment variables in a real scenario
  # This is just for validation purposes
}

module "vpc" {
  source = "../../modules/vpc"
  
  name        = "test-vpc"
  environment = "dev"
  cidr_block  = "10.0.0.0/16"
  
  tags = {
    Project     = "BrainIncubator"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
