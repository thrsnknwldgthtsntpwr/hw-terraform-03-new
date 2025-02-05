resource "yandex_compute_instance" "web" {
  depends_on = [ resource.yandex_compute_instance.db ]
  count = 2
  zone = var.default_zone
  name = "web-${count.index+1}"
  platform_id = var.vms.web.platform_id
  
  resources {
    cores = var.vms.web.cores
    memory = var.vms.web.ram
    core_fraction = var.vms.web.core_fraction
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = var.vms.web.nat
    security_group_ids = [ yandex_vpc_security_group.example.id ]
  }
  
  boot_disk {
    initialize_params {
      image_id = var.vms.web.image
    }
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${local.local_admin}:${file(local.local_admin_public_key)}"
  }
}