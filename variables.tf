# variable
variable "xoa_host_url" {
  type = string
  # ws:// http and wss:// https
  default = "wss://xen-orchestra.local.net"

}

# user from xen orchestra
variable "xoa_user" {
  type = string
  #default = ""

}

# user password
variable "xoa_password" {
  type = string
  #default = ""

}

variable "pool" {
  type = string
  default = "yourhostispool.local.net"

}

# for terraform.auto.tfvars
variable "deploy_vm" {

  type = map(any)

  default = {}
}
