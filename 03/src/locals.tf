locals {
  ssh-key = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  
  for_hosts = {
      webservers = yandex_compute_instance.my_web_vm
      databases = yandex_compute_instance.my_spare_vm
      storage = yandex_compute_instance.my_disk_vm
   }   
}
