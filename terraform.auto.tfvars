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
