
provider "yandex" {
  token     = "<токен облака>"
  cloud_id  = "<id облака>"
  folder_id = "<id папки>"
  zone      = "<ru-central1-a>"
}

#data "yandex_compute_image" "ubuntu" {
#  family = "ubuntu-2004-lts"
#}
# Образ берем тут https://cloud.yandex.ru/marketplace/products/yc/ubuntu-20-04-lts
resource yandex_compute_image "ubuntu" {
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

resource "yandex_compute_instance" "vm" {
  name        = "netologydz72"
  hostname    = "netologydz72.local"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
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
}