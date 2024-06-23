
module "proxmox-vm" {
  source = "../"
  vm_name = "test001"
  node_name = "hp"
  iso_datastore_id = "local"
  vm_datastore_id = "data"
}