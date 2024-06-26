terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.60.0"
    }
    remote = {
      source  = "tenstad/remote"
      version = "0.1.3"
    }
    time = {
      source = "hashicorp/time"
      version = "0.11.2"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = var.proxmox_insecure

  ssh {
    agent = var.proxmox_ssh_agent
  }
}

provider "remote" {
  max_sessions = 2
}