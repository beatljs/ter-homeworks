terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_mdb_mysql_database" "test" {
  cluster_id = var.db_params.claster_id
  name       = var.db_params.db_name
}

resource "yandex_mdb_mysql_user" "app" {
  cluster_id = var.db_params.claster_id
  name       = var.db_params.db_user
  password   = var.db_params.db_pass
  permission {
    database_name = var.db_params.db_name
    roles         = ["ALL"]
  }
}

variable "db_params" {
  default = {
    db_name = "MyDB"
    claster_id = ""
    db_user = ""
    db_pass = ""
  }
}
