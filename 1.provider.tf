terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0.0"
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
      version = "~> 2.11.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.1.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }

  required_version = ">= 1.2.0"
}
provider "aws" {
  region     = "ap-southeast-1"
   access_key = "AKIARREQSXCAZXFO7W4G"
  secret_key = "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" 
}
provider "null" {}
provider "external" {}
provider "kubernetes" {
  config_path = "/home/ubuntu/terraform/.kube/config"
}
//Remote backend S3
terraform {
  backend "s3" {
    bucket         = "remotebackend-1"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "remotebackend-1"

  }
}

