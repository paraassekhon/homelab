terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.85.1"
    }
  }
}

provider "proxmox" {

  #username = var.username
  #password = var.password

  endpoint = var.api_url
  api_token = "${var.token_id}=${var.token_secret}"
  insecure = true

#   ssh {
#     agent = true
#     username = "terraform"
#   }
}

resource "proxmox_virtual_environment_vm" "vm"{
    name = "ubuntu-2204-template-clone"
    node_name = "pve"
    
    clone {
        vm_id = 100
    }

    agent {
        enabled = true
    }

    memory {
        dedicated = 768
    }

    initialization {
        dns {
            servers = ["1.1.1.1"]
        }
        ip_config{
            ipv4{
                address = "dhcp"
            }
        }
    }
   
}


