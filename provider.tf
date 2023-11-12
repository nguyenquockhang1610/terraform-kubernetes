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
      version = "~> 1.1.1"
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
  region     = "us-east-1"
  access_key = "AKIA5TNVOOFRK2FIEDQM"
  secret_key = "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"
}
provider "null" {}
provider "external" {}
provider "kubernetes" {
  config_path = "/home/ubuntu/.kube/config"
}
//Remote backend S3
terraform {
  backend "s3" {
    bucket         = "remote-backend-01"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "remote-backend-01"

  }
}

