/* #создаем облачную сеть
resource "yandex_vpc_network" "develop" {
  name = "develop"
}

#создаем подсеть
resource "yandex_vpc_subnet" "develop" {
  name           = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.1.0/24"]
} */

module "test_net" {
  source = "./modules/my_vpc"
  net_name = "m_develop"
  zone_name = "ru-central1-a"
  cidr = "10.0.1.0/24"
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.test_net.mod_net_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [ module.test_net.mod_subnet_id ]
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