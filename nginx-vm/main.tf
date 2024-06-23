data "local_file" "key" {
  filename = pathexpand("~/.ssh/id_rsa.pub")
}

# locals {
#   vm_name      = "nginx-vm"
#   vm_id        = "12312"
#   vm_username  = "myadmin"
#   vm_password  = "my_password123!"
#   vm_memory    = "2048"
#   vm_cpu_cores = "1"
#   vm_networking = {
#     0 : {
#       bridge  = "vmbr0"
#       address = "192.168.0.26/24"
#       gateway = "192.168.0.1"
#     }
#   }
#
#   vm_dns_servers = [
#     "192.168.0.2",
#     "192.168.0.1"
#   ]
#   custom_script = "apt update; apt install -yq nginx && systemctl enable nginx && systemctl restart nginx"
# }

module "vms" {
  source         = "git@github.com:oleksdovz/terraform-proxmox-modules.git//proxmox-vm?ref=main"
  vm_name        = var.vm_name
  vm_id          = var.vm_id
  vm_username    = var.vm_username
  vm_memory      = var.vm_memory
  vm_cpu_cores   = var.vm_cpu_cores
  qcow_url       = var.qcow_url
  vm_networking  = var.vm_networking
  vm_dns_servers = var.vm_dns_servers
  ssh_public_key = data.local_file.key.content
  custom_script  = var.custom_script
}