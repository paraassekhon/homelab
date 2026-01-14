resource "proxmox_lxc" "qbit-lxc" {
  target_node  = "pve"
  hostname     = "qbittorrent"
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  ostype       = "ubuntu"
  memory       = "4096"
  cpulimit     = "2"
  cores        = "2"
  swap         = "4096"
  vmid         = 119
  start        = true
  onboot       = true
  unprivileged = false
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
    ip     = "192.168.1.190/24"
    gw = "192.168.1.1"
  }
}