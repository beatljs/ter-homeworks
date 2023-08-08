locals {
 
  res-list = [yandex_compute_instance.my_web_vm,yandex_compute_instance.my_spare_vm,[yandex_compute_instance.my_disk_vm]]
  

  vm-list = flatten([
    for k, v in local.res-list : [
      for kk, vv in v : {
        name = vv.name
        id = vv.id
        fqdn = vv.fqdn
      }
    ]  
  ])
}






output vm-list {
  value = local.vm-list
#  yandex_compute_instance.my_web_vm[*].name)
}
