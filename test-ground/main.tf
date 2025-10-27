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









# # Creates a proxmox_vm_qemu entity named blog_demo_test
# resource "proxmox_vm_qemu" "blog_demo_test1" {
#   name = "test_vm${count.index + 1}" # count.index starts at 0
#   #name = "test-vm-01"
#   count = 1 # Establishes how many instances will be created 
#   target_node = var.proxmox_host

#   # References our vars.tf file to plug in our template name
#   clone = var.template_name
#   # Creates a full clone, rather than linked clone 
#   # https://pve.proxmox.com/wiki/VM_Templates_and_Clones
#   full_clone  = "true"

#   # VM Settings. `agent = 1` enables qemu-guest-agent
#   agent = 1
#   os_type = "cloud-init"
#   cores = 2
#   sockets = 1
#   cpu = "host"
#   memory = "2048"
#   scsihw = "virtio-scsi-pci"
#   bootdisk = "scsi0"

#   disk {
#     slot = 0
#     size = "50G"
#     type = "scsi"
#     storage = "intel-storage" # Name of storage local to the host you are spinning the VM up on
#     # Enables SSD emulation
#     ssd = 1
#     # Enables thin-provisioning
#     discard = "on"
#     #iothread = 1
#   }

#   network {
#     model = "virtio"
#     bridge = var.nic_name
#     #tag = var.vlan_num # This tag can be left off if you are not taking advantage of VLANs
#   }


#   lifecycle {
#     ignore_changes = [
#       network,
#     ]
#   }
#   #provisioner "local-exec" {
#     # Provisioner commands can be run here.
#     # We will use provisioner functionality to kick off ansible
#     # playbooks in the future
#     #command = "touch /home/tcude/test.txt"
#   #}
# }