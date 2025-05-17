terraform {
  required_version = ">= 1.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9"
    }
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "< 18.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.21"
    }
  }
}
