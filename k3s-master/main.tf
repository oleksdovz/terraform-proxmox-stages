data "local_file" "key" {
  filename = pathexpand("${var.ssh_public_key}")
}

module "vms" {
  source                = "git@github.com:oleksdovz/terraform-proxmox-modules.git//proxmox-vm?ref=main"
  ssh_public_key        = data.local_file.key.content
  node_name             = var.node_name
  environment           = var.environment
  iso_datastore_id      = var.iso_datastore_id
  vm_datastore_id       = var.vm_datastore_id
  qcow_url              = var.qcow_url
  vm_username           = var.vm_username
  vm_password           = var.vm_password
  vm_name               = var.vm_name
  vm_id                 = var.vm_id
  custom_script         = var.custom_script
  vm_startup_order      = var.vm_startup_order
  vm_startup_up_delay   = var.vm_startup_up_delay
  vm_startup_down_delay = var.vm_startup_down_delay
  vm_dns_domain         = var.vm_dns_domain
  vm_dns_servers        = var.vm_dns_servers
  vm_networking         = var.vm_networking
  vm_memory             = var.vm_memory
  vm_memory_floating    = var.vm_memory_floating
  vm_memory_shared      = var.vm_memory_shared
  vm_cpu_architecture   = var.vm_cpu_architecture
  vm_cpu_cores          = var.vm_cpu_cores
  vm_cpu_sockets        = var.vm_cpu_sockets
  vm_cpu_type           = var.vm_cpu_type
  vm_disk_size          = var.vm_disk_size
  vm_os_config          = var.vm_os_config
}


locals {
  remote_ip = replace(var.vm_networking.0["address"], "/24", "")
}

data "null_data_source" "get_k3s_config" {
  connection {
    host = local.remote_ip
    user = var.vm_username
    password = var.vm_password
  }

  provisioner "remote-exec" {
    inline_script = <<EOF
      cat /etc/rancher/k3s/config.yaml
    EOF

    stdout_file = "k3s_config_${count.index}.yaml"
  }
  depends_on = [ module.vms]
}

output "k3s_config" {
  value = data.null_data_source.get_k3s_config.stdout_file
  sensitive = true
}