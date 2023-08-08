resource "yandex_compute_instance" "my_spare_vm" {
  depends_on = [ yandex_compute_instance.my_web_vm ]
  for_each = var.vms_resources
  name        = "netology-develop-platform-${each.value.name}"
  platform_id = "standard-v1"

  resources {
    cores  = each.value.cores
    memory = each.value.mem
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = each.value.disk_size
    }   
  }

  metadata = {
    ssh-keys = local.ssh-key
  }

  scheduling_policy { preemptible = true }

  network_interface { 
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}

