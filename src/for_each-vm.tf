resource "yandex_compute_instance" "db" {
  for_each = { for hosts in var.each_vm : hosts.vm_name => hosts }
    name     = each.value.vm_name
    platform_id = each.value.platform_id
    resources {
      cores         = each.value.cpu
      memory        = each.value.ram
      core_fraction = each.value.core_fraction
    }
    boot_disk {
      initialize_params {
        image_id = each.value.image
        size = each.value.disk_volume
      }
    }
  scheduling_policy {
    preemptible = each.value.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${local.local_admin}:${file(local.local_admin_public_key)}"
  }
}