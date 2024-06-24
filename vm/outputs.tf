output "cloud_config_id" {
  description = "cloud_config_id"
  value = module.vms.cloud_config_id
}

output "vm_id" {
  description = "vm_id"
  value = module.vms.vm_id
}

output "vm_ipv4_addresses" {
  description = "vm_ipv4_addresses"
  value = module.vms.vm_ipv4_addresses
}

output "qcow2_img_id" {
  description = "qcow2_img.id"
  value = module.vms.qcow2_img_id
}