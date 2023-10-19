terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.19.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.17.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1.0"
    }
  }

  required_version = ">= 1.2.0"
}
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAZWNUCYWD7WQYBQQC"
  secret_key = "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"
}
provider "null" {}
provider "external" {}
provider "kubernetes" {}
//Remote backend S3
terraform {
  backend "s3" {
    bucket         = "remotebackend-01"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "remotebackend-01"

  }
}

