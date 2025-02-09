terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.83.1"
        }
    }
    
    backend "s3" {
        bucket = "avin-remote-state"
        key = "expense-dev-infra-backend"
        region = "us-east-1"
        dynamodb_table = "avin-locking"
    }
}

provider "aws" {
    region = "us-east-1"
}