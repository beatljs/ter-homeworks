#создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = "develop"
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
  }

/* module "mysql_cl" {
  source = "./modules/my_claster"
  is_one = false
  cl_params = {
    name             = "Dev_cluster"
    net_id = yandex_vpc_network.develop.id
  }
 }

module "my_db_and_user" {
  source    = "./modules/my_db"
  db_params = {
    db_name = "MyTestDB"
    db_user = "app"
    db_pass = "derParol"
    claster_id = module.mysql_cl.out_claster_id
  }

}*/


module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=1.0.0"
  env_name        = "develop"
  network_id      = yandex_vpc_network.develop.id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [ yandex_vpc_subnet.develop.id ]
  instance_name   = "web"
  instance_count  = 1
  image_family    = "ubuntu-2004-lts"
  public_ip       = true

  metadata = {
      user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
      serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars     = {
    auth_key1 = file("~/.ssh/id_ed25519.pub")
    auth_key2 = file("~/.ssh/id_rsa.pub")
  }
}


data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

resource "vault_generic_secret" "my_secret" {
  path = "secret/very_imprtant"

  data_json = <<EOT
{
  "sec1":   "very big secret",
  "sec2":   "another big secret"
}
EOT
}

output "vault_example" {
 value = nonsensitive(data.vault_generic_secret.vault_example.data)
}

