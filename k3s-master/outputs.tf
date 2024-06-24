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
#
# output "config" {
#   description = "config"
#   value = module.k3s-master.k3s_config
# }
#

output "ssh_private_key" {
  description = "ssh_private_key"
  value = module.k3s-master.ssh_private_key
}