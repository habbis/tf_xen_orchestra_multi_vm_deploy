data "xenorchestra_pool" "pool" {
    name_label = "hf-xcp08.no.habbfarm.net"
    name_label = var.pool
}

data "xenorchestra_template" "vm_template" {
    for_each = var.deploy_vm
    name_label = each.value.vm_template
}

data "xenorchestra_network" "vm_network" {
  for_each = var.deploy_vm
  name_label = each.value.network
}


resource "xenorchestra_vm" "vm" {
    for_each = var.deploy_vm
    memory_max = tostring(each.value.ram)
    cpus  = tostring(each.value.cpu)
    auto_poweron = true

    cloud_config = templatefile("cloud_config.tftpl", {
     name = each.value.name
     zone = each.value.zone

    })
    cloud_network_config = templatefile("cloud_network_config.tftpl", {
     ipv4 =  each.value.ipv4
     ipv4_gw =  each.value.ipv4_gw
     dns01   =  each.value.dns01
     dns02   =  each.value.dns02
    })

    name_label = "${each.value.name}.${each.value.zone}"
    name_description = "by managed terraform"
    template = data.xenorchestra_template.vm_template[each.key].id

    # Prefer to run the VM on the primary pool instance
    affinity_host = data.xenorchestra_pool.pool.master
    network {
      network_id = data.xenorchestra_network.vm_network[tostring(each.key)].id
    }

    disk {
      sr_id = each.value.sr_id
      name_label = each.value.name
      size = tostring(each.value.disk)
    }

    tags = [
      "${each.value.tag_os}",
      "${each.value.tag_os_release}",
    ]

    // Override the default create timeout from 5 mins to 20.
    timeouts {
      create = "20m"

  }

}








