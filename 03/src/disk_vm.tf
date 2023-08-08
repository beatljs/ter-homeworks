resource "yandex_compute_disk" "my_disks" {
  count      = 3
  name       = "empty-disk-${count.index+1}"
  type       = "network-hdd"
  zone       = var.default_zone
  size       = 1
}

resource "yandex_compute_instance" "my_disk_vm" {
  name        = "netology-develop-platform-disk-vm"
  platform_id = "standard-v1"
  
  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
      type = "network-hdd"
      size = 5
    } 
  }  
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.my_disks
    content {
     # disk_id = yandex_compute_disk.my_disks[secondary_disk.name].id
      disk_id = secondary_disk.value.id
      auto_delete = true 
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

