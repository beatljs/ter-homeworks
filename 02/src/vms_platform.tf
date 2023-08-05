# 1 VM

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image.family"
}  

variable "vm_web_patform_id" {
  type        = string
  default     = "standard-v1"
  description = "yandex_compute_instance.platform_id"
}  


# 2 VM

variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image.family"
}  

variable "vm_db_patform_id" {
  type        = string
  default     = "standard-v1"
  description = "yandex_compute_instance.platform_id"
}  


