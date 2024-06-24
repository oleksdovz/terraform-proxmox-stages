data "local_file" "key" {
  filename = pathexpand("${var.ssh_public_key}")
}


module "vms" {
  source         = "git@github.com:oleksdovz/terraform-proxmox-modules.git//proxmox-vm?ref=main"
  environment    = var.environment
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