locals {
  custom_script = "date > /tmp/custom-script; ${var.custom_script} >> /tmp/custom-script 2>&1 "
  vm_tag = replace(replace(replace(replace(replace(jsonencode(var.vm_networking), "\"", ""), "{", "\n"), "}", "\n"), ":", "="), ",", "\n")
}

resource "proxmox_virtual_environment_download_file" "qcow2_img" {
  content_type        = "iso"
  datastore_id        = var.iso_datastore_id
  node_name           = var.node_name
  url                 = var.qcow_url
  overwrite_unmanaged = true
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = var.iso_datastore_id
  node_name    = var.node_name

  source_raw {
    data      = <<-EOF
    #cloud-config
    chpasswd:
      list: |
        root:${var.vm_password}
        ${var.vm_username}:${var.vm_password}
      expire: false
    hostname: ${var.vm_name}
    packages:
      - qemu-guest-agent
      - openssh-server
    users:
      - default
      - name: ${var.vm_username}
        groups: sudo
        shell: /bin/bash
        ssh-authorized-keys:
          - trimspace(var.list_public_key_openssh)
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
    - [ systemctl, daemon-reload ]
    - [ systemctl, enable, qemu-guest-agent ]
    - [ systemctl, restart, --no-block, qemu-guest-agent ]
    - [ sh, -cx, "${local.custom_script}"]
    EOF
    file_name = "${var.vm_id}.${var.vm_name}.cloud-config.yaml"
  }
}


resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.vm_name
  description = "Hostname: ${var.vm_name}\n\nSystem username: ${var.vm_username}\n${local.vm_tag}"
  tags = ["terraform", "${var.vm_name}", "vm"]

  node_name = var.node_name
  vm_id     = var.vm_id

  on_boot = true

  memory {
    dedicated = var.vm_memory
    floating  = var.vm_memory_floating
    shared    = var.vm_memory_shared
  }

  cpu {
    architecture = var.vm_cpu_architecture
    cores        = var.vm_cpu_cores
    sockets      = var.vm_cpu_sockets
    type         = var.vm_cpu_type
  }

  agent {
    enabled = true
    trim    = true
  }

  stop_on_destroy = true

  startup {
    order      = var.vm_startup_order
    up_delay   = var.vm_startup_up_delay
    down_delay = var.vm_startup_down_delay
  }

  disk {
    datastore_id = var.vm_datastore_id
    file_id      = proxmox_virtual_environment_download_file.qcow2_img.id
    interface    = "scsi0"
    size         = var.vm_disk_size
  }

  initialization {
    dns {
      domain  = var.vm_dns_domain
      servers = var.vm_dns_servers
    }

    datastore_id = var.iso_datastore_id

    dynamic "ip_config" {
      for_each = var.vm_networking
      content {
        ipv4 {
          address = ip_config.value["address"]
          gateway = ip_config.value["gateway"]
        }
        ipv6 {}
      }
    }

    user_account {
      keys     = var.list_public_key_openssh
      password = var.vm_password
      username = "${var.vm_username}"
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  dynamic "network_device" {
    for_each = var.vm_networking
    content {
      bridge = network_device.value["bridge"]
    }
  }

  operating_system {
    type = var.vm_os_config
  }

  tpm_state {
    datastore_id = var.vm_datastore_id
    version      = "v2.0"
  }

  serial_device {}
}

