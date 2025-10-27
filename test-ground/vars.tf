variable "ssh_key" {
  type = string
}

variable "proxmox_host" {
  type = string
}

variable "template_name" {
  type = string
}

variable "nic_name" {
  type = string
}

variable "api_url" {
  type = string
}

variable "token_secret" {
  type = string
  sensitive = true
}

variable "token_id" {
  type = string
}

variable "username" {
  type = string
}


variable "password" {
  type = string
}