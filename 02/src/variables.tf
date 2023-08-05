###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "name_prefix" {
  default = "netology-develop-platform"
}

variable "name_suff_vm1" {
  default = "web"
}

variable "name_suff_vm2" {
  default = "db"
}

variable "vms_resources" {
   default = {
      vm_web_resources = {
        cores = 2
        mem = 2
        core_fraction=5
      }
      vm_db_resources = {
        cores = 2
        mem = 2
        core_fraction=20
      }
   }   
}

variable "vms_metadata" {
  default = {
    serial-port-enable = 1
    ssh-key = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFzIYA9F1G3dSQ6Ngnk+XSFESJgTn1Rx4ghJ0wv6WSvN beatl@OWEN"
  }
}
