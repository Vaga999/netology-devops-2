
# resource "yandex_storage_bucket" vagatestdz73 {
# access_key = "	"
# secret_key = "	"
# bucket = "bucketdz7-3"
# }

resource "yandex_compute_image" "ubuntu" {
  name          = "ubuntu-2004-lts"
  source_image  = "fd8qs44945ddtla09hnr"
}

resource "yandex_vpc_network" "net" {
  name = "networkdz72"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet"
  network_id     = resource.yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
}
locals {
  instance = {
    stage = 1
    prod  = 2
  }
}
resource "yandex_compute_instance" "vm-count" {
  name = "vm-${count.index}-${terraform.workspace}"
  # hostname    = "netologydz72.local"
  platform_id = "standard-v1"


  resources {
    cores  = 2
    memory = 2
    # core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = resource.yandex_compute_image.ubuntu.id
      type     = "network-hdd"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
    ipv6      = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  count = local.instance[terraform.workspace]

}

locals {
  id = toset([
    "1",
    "2",
  ])
}

resource "yandex_compute_instance" "vm-for" {
  for_each = local.id
  name     = "vm-${each.key}-${terraform.workspace}-dz"

  resources {
    cores  = "2"
    memory = "4"
  }

  boot_disk {
    initialize_params {
      image_id = resource.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
    ipv6      = false
  }

}