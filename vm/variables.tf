variable "proxmox_endpoint" {
  description = "Proxmox Host of VM, ex https://x.x.x.x:8006/ "
  type        = string
}

variable "proxmox_username" {
  description = "Proxmox Host username, ex root@pam"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox Host password"
  type        = string
}
variable "proxmox_insecure" {
  description = "Proxmox Host insecure connection"
  type        = bool
  default     = true
}
variable "proxmox_ssh_agent" {
  description = "Proxmox Host insecure connection"
  type        = bool
  default     = false
}

####
variable "environment" {
  description = "environment tag"
  type        = string
  default     = "proxmox"
}

variable "node_name" {
  description = "Proxmox node(Host) of VM"
  type        = string
  default     = "hp"
}

variable "iso_datastore_id" {
  description = "Proxmox storage volume for iso iso_datastore_id"
  type        = string
  default     = "local"
}

variable "vm_datastore_id" {
  description = "Proxmox storage volume for VM iso_datastore_id"
  type        = string
  default     = "data"
}

variable "qcow_url" {
  description = "URL to download img, qcow_url"
  type        = string
  default     = "https://cloud-images.ubuntu.com/noble/20240612/noble-server-cloudimg-amd64.img"
}

variable "vm_username" {
  description = "username for VM"
  default     = "ubuntu1"
  type        = string
}

variable "vm_password" {
  description = "password for VM"
  default     = "ubuntu1"
  type        = string
}

variable "vm_name" {
  description = "Name of VM"
  default     = "ubuntu-vm"
  type        = string
}

variable "vm_id" {
  description = "Proxmox ID of VM"
  default     = "41321"
  type        = number
}

variable "ssh_public_key" {
  description = "ssh public key"
  type        = string
}

variable "custom_script" {
  description = "custom_script for cloudinit, bash one line script"
  type        = string
  default     = "date"
}

variable "vm_startup_order" {
  description = "vm_startup_order time parameters for VM"
  type        = number
  default     = "3"
}
variable "vm_startup_up_delay" {
  description = "vm_startup_up_delay time parameters for VM"
  type        = number
  default     = "60"
}

variable "vm_startup_down_delay" {
  description = "vm_startup_down_delay time parameters for VM"
  type        = number
  default     = "60"
}

# networking
variable "vm_dns_domain" {
  description = "vm_dns_domain parameters for VM"
  type        = string
  default     = "home"
}
variable "vm_dns_servers" {
  description = "vm_dns_domain parameters for VM"
  type = list(string)
  default = [
    "192.168.0.2",
    "192.168.0.1"
  ]
}

variable "vm_networking" {
  description = "vm_networking parameters for VM"
  type = map(any)
  default = {
    0 : {
      bridge  = "vmbr0"
      address = "192.168.0.26/24"
      gateway = "192.168.0.1"
    },
    "1" : {
      bridge  = "vmbr100"
      address = "192.168.100.26/24"
      gateway = "192.168.100.1"
    }
  }
}

variable "vm_memory" {
  description = "vm_memory parameters for VM"
  type        = number
  default     = "1024"
}
variable "vm_memory_floating" {
  description = "vm_memory_floating parameters for VM"
  type        = number
  default     = "0"
}

variable "vm_memory_shared" {
  description = "vm_memory_shared parameters for VM"
  type        = number
  default     = "0"
}

# cpu
variable "vm_cpu_architecture" {
  description = "vm_cpu_architecture parameters for VM"
  type        = string
  default     = "x86_64"
}
variable "vm_cpu_cores" {
  description = "vm_cpu_cores parameters for VM"
  type        = number
  default     = "1"
}
variable "vm_cpu_sockets" {
  description = "vm_cpu_sockets parameters for VM"
  type        = number
  default     = "1"
}
variable "vm_cpu_type" {
  description = "vm_cpu_type parameters for VM"
  type        = string
  default     = "x86-64-v2-AES"
}

# disk
variable "vm_disk_size" {
  description = "vm_cpu_type parameters for VM"
  type        = number
  default     = 30
}

# os type
variable "vm_os_config" {
  description = "vm_os_config parameters for VM. https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#operating_system"
  type        = string
  default     = "l26"
}
