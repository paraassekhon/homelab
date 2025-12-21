resource "proxmox_lxc" "prowlarr-lxc" {
  target_node  = "pve"
  hostname     = "prowlarr"
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  ostype       = "ubuntu"
  memory       = "1024"
  cpulimit     = "1"
  cores        = "1"
  swap         = "1024"
  vmid         = 118
  start        = true
  onboot       = true
  unprivileged = true
  password = var.password
  ssh_public_keys = var.ssh_pub

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.186/24"
    gw = "192.168.1.1"
  }
}