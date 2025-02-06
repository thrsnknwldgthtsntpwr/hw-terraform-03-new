resource "yandex_compute_disk" "hdd" {
  count = 3
  name  = "disk-${count.index}"
  type = "network-hdd"
  size = 1
}


resource "yandex_compute_instance" "storj" {
  name     = var.vms.storj.name
  platform_id = var.vms.storj.platform_id
  resources {
    cores         = var.vms.storj.cores
    memory        = var.vms.storj.ram
    core_fraction = var.vms.storj.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.vms.storj.image
    }
  }
  scheduling_policy {
    preemptible = var.vms.storj.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vms.storj.nat
  }
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.hdd.*.id
    content {
      disk_id = secondary_disk.value
    }
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${local.local_admin}:${file(local.local_admin_public_key)}"
  }
}