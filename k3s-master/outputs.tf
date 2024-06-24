output "cloud_config_id" {
  description = "cloud_config_id"
  value = module.master-vm.cloud_config_id
}

output "vm_id" {
  description = "vm_id"
  value = module.master-vm.vm_id
}

output "config" {
  description = "config"
  value = module.k3s-master.k3s_config
}

resource "local_file" "config" {
  content  = module.k3s-master.k3s_config
  filename = "${path.cwd}/config"
}