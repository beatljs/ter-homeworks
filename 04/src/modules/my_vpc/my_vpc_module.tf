terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_vpc_network" "my_net" {
  name = var.net_name
}

resource "yandex_vpc_subnet" "subnet" {
  count = length(var.zone_cidr_name)
  name           = "${var.net_name}-${var.zone_cidr_name[count.index].zone}"
  zone           = var.zone_cidr_name[count.index].zone
  network_id     = yandex_vpc_network.my_net.id
  v4_cidr_blocks = [var.zone_cidr_name[count.index].cidr]
}

variable "net_name" {
  type = string
  default = ""
  description = "Network name for pass to module "
}

variable "zone_cidr_name" {
  type = list(object({
     zone = string
     cidr = string
  }))
  default = []
  description = "Zone and cidr name for pass to module "
}

variable "cidr" {
  type = string
  default = ""
  description = "v4_cidr_blocks for pass to module "
}

output "mod_net_id" {
  value = yandex_vpc_network.my_net.id
  description = "Output: yandex_vpc_network.*.id from module"
}

output "mod_subnet_id" {
  value = yandex_vpc_subnet.subnet[*].id
  description = "Output: yandex_vpc_subnet.*.id from module"
}