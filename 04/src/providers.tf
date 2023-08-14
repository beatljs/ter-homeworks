terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~>0.90"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2"
    }
  }

  backend "s3" {
    endpoint = "s3.yandexcloud.net"
    bucket = "tfstate-develop-beatl"
    region = "ru-central1"
    key = "terraform.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
    encrypt = false
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g67o4e6mtmogm6m0l2/etnacs3auccru7hoflov"
    dynamodb_table = "tfstate-develop"
  }

  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

provider "vault" {
 address = "http://localhost:8200"
 skip_tls_verify = true
 token = var.vault_token
}
