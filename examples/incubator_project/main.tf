terraform {
  required_providers {
    cloudsigma = {
      source  = "cloudsigma/cloudsigma"
      version = "~> 1.0"
    }
  }
  
  # Example backend configuration (commented out)
  # backend "s3" {
  #   bucket         = "brainsait-terraform-states"
  #   key            = "incubator/infrastructure.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}

provider "cloudsigma" {
  # Provider configuration is sourced from environment variables by default:
  # CLOUDSIGMA_USERNAME, CLOUDSIGMA_PASSWORD, CLOUDSIGMA_LOCATION
}

# Create a VPC network for the incubator environment
module "vpc" {
  source = "../../modules/vpc"
  
  name        = "${var.project_name}-vpc"
  environment = var.environment
  cidr_block  = var.vpc_cidr
  
  tags = local.common_tags
}

# Create Kubernetes cluster with K3s
module "k3s_cluster" {
  source = "../../modules/kubernetes"
  
  name           = "${var.project_name}-cluster"
  environment    = var.environment
  vpc_id         = module.vpc.vpc_id
  node_count     = var.kubernetes_node_count
  instance_type  = var.kubernetes_instance_type
  
  tags = local.common_tags
}

# Setup database for applications
module "database" {
  source = "../../modules/database"
  
  name         = "${var.project_name}-db"
  environment  = var.environment
  engine       = "postgresql"
  engine_version = "13"
  instance_type = var.db_instance_type
  
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
  
  tags = local.common_tags
}

# Configure Redis for caching
module "redis" {
  source = "../../modules/redis"
  
  name        = "${var.project_name}-redis"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
  
  tags = local.common_tags
}

# Setup load balancer with TLS termination
module "load_balancer" {
  source = "../../modules/load_balancer"
  
  name        = "${var.project_name}-lb"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
  
  certificate_arn = var.certificate_arn
  
  target_groups = {
    app = {
      port     = 80
      protocol = "HTTP"
      health_check = {
        path = "/health"
        port = "traffic-port"
      }
    }
  }
  
  tags = local.common_tags
}
