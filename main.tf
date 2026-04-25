
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

locals {
    state_bucket = "phoenix-jola-terraform-state-${var.environment}"
    common_tags = {
        Environment = var.environment
        ManagedBy   = "terraform"
        Project     = "bootstrap"    
        Owner       = "Jola"  
    }
}

resource "aws_s3_bucket" "state_bucket" {
    bucket = local.state_bucket
    tags = local.common_tags
}

resource "aws_s3_bucket_public_access_block" "state_bucket_access" {
    bucket = aws_s3_bucket.state_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true

}

resource "aws_dynamodb_table" "state-locking-dynamodb-table" {
  name           = "StateLockTerraform"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.common_tags
}