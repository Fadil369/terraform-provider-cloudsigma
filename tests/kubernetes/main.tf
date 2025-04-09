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

module "kubernetes" {
  source = "../../modules/kubernetes"
  
  name        = "test-k3s-cluster"
  environment = "dev"
  vpc_id      = "vpc-12345" # This would be an actual VPC ID in a real scenario
  os_image_uuid = "ubuntu-20.04" # This would be an actual image UUID in a real scenario
  
  tags = {
    Project     = "BrainIncubator"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
