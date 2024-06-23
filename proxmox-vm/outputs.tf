output "cloud_config_id" {
  description = "cloud_config_id"
  value = proxmox_virtual_environment_file.cloud_config.id
}

output "vm_id" {
  description = "vm_id"
  value = proxmox_virtual_environment_vm.vm.id
}

output "vm_ipv4_addresses" {
  description = "vm_ipv4_addresses"
  value = proxmox_virtual_environment_vm.vm.ipv4_addresses
}


output "qcow2_img_id" {
  description = "qcow2_img.id"
  value = proxmox_virtual_environment_download_file.qcow2_img.id
}