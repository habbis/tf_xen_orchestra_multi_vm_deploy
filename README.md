# Deploy vm with terraform on xen orchestra


This terraform repo you can deploy vm with cloud-init to xen orchestra with xcp-ng.


### What do you need.

First a template with cloud-init installed


Packages to install.
```
cloud-init
cloud-guest-utils
```

And you may need to enable cloud-init service.
```
systemctl enable cloud-init
```


### terraform config layout


#### main.tf

The file main.tf have provider version info and provider login info no more
no less .



#### variables.tf

All variables are placed here on thing of note is type = map(any)
this is used with terraform.auto.tfvars and for_each to have more
flexbile variable layout.

```
# for terraform.auto.tfvars
variable "deploy_vm" {

  type = map(any)

  default = {}
}

```

#### terraform.auto.tfvars

used with terraform.auto.tfvars and for_each to have more flexbile variable layout.

Here i define a new vm to deploy under deply_vm.


```
deploy_vm = {
# RAM
# 1073733632 1G ram
# 2073733632 is 2G ram
# 4294967296 is 4G ram
# disk
# 150000 is 15G
# storage id for local-vm host hf-xcp08
#  33ab6c88-6beb-dfa8-aa09-df2994b11d86
  test01 = {
    "name"                  = "test01"
    "vm_template"           = "deb11-tmpl-vm"
    "tag_os"                = "debian"
    "tag_os_release"        = "bullseye"
    "ram"                   = "1073733632"
    "cpu"                   = "1"
    "disk"                  = "16106127360"
    "sr_id"                 = "33ab6c88-6beb-dfa8-aa09-df2994b11d86"
    "network"               = "test"
    "ipv4"                  = "10.0.0.10/24"
    "ipv4_gw"               = "10.0.0.1"
    "dns01"                 = "8.8.8.8"
    "dns02"                 = "1.1.1.1"
    "zone"                  = "local.net"

   }
}
```

#### cloud-init config.




The file cloud_config.tftpl is a terraform template with [cloud-init](https://cloudinit.readthedocs.io/en/latest/topics/format.html) system config.

```
#cloud-config
hostname: ${name}
user: ansible
ssh_authorized_keys:
  - ssh-rsa yoursshkey
  - ssh-rsa yoursshkey
manage_etc_hosts: localhost
fqdn: ${name}.${zone}
package_upgrade: true
users:
 - default
  # to encrypt password mkpasswd -m sha-512
 - passwd: yourpasswordhash

```

The file cloud_network_config.tftpl is a terraform template with [cloud-init network v1 config](https://cloudinit.readthedocs.io/en/latest/topics/network-config-format-v1.html) system config.

