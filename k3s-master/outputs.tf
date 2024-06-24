output "cloud_config_id" {
  description = "cloud_config_id"
  value = module.k3s-master.cloud_config_id
}

output "vm_id" {
  description = "vm_id"
  value = module.k3s-master.vm_id
}

output "vm_ipv4_addresses" {
  description = "vm_ipv4_addresses"
  value = module.k3s-master.vm_ipv4_addresses
}

output "config" {
  description = "config"
  value = module.k3s-master.k3s_config
}

