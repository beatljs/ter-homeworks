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
  name           = "${var.net_name}-${var.zone_name}"
  zone           = var.zone_name
  network_id     = yandex_vpc_network.my_net.id
  v4_cidr_blocks = [var.cidr]
}

variable "net_name" {
  type = string
  default = ""
  description = "Network name for pass to module "
}

variable "zone_name" {
  type = string
  default = ""
  description = "Zone name for pass to module "
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
  value = yandex_vpc_subnet.subnet.id
  description = "Output: yandex_vpc_subnet.*.id from module"
}