terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_vpc_subnet" "develop" {
  count = local.hosts_count
  name           = "develop-ru-central1-a-${count.index+1}"
  zone           = "ru-central1-a"
  network_id     = var.cl_params.net_id
  v4_cidr_blocks = ["10.0.${count.index+1}.0/24"]
}

resource "yandex_mdb_mysql_cluster" "example" {
  name        = var.cl_params.name
  environment = "PRESTABLE"
  network_id  = var.cl_params.net_id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  maintenance_window {
    type = "ANYTIME"
  }

  dynamic "host" {
    for_each = yandex_vpc_subnet.develop
    content {
      zone = host.value.zone
      subnet_id = host.value.id
      name = host.value.name
    }
  }
}

variable "is_one" {
  type = bool
  default = false
}

locals {
  hosts_count = var.is_one ? 1 : 3
}

variable "cl_params" {
  default = {
    name = "MySQL_claster"
    net_id = ""
  }
}

output "out_claster_id" {
  value=yandex_mdb_mysql_cluster.example.id
}