terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.60.0"
    }
  }
}


# provider "proxmox" {
#   endpoint = "https://x.x.x.x:8006/"
#   username = "root@pam"
#   password = "XXXXXXXXXXXXXX"
#   insecure = true
#
#   ssh {
#     agent = true
#   }
# }