

provider "yandex" {
  token     = "	"
  cloud_id  = "	"
  folder_id = "b1gq945akrsqbn63337t"
  zone      = "ru-central1-a"
}

# resource "yandex_storage_bucket" vagatestdz73 {
  # access_key = "	"
  # secret_key = "	"
  # bucket = "bucketdz7-3"
}

 backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "bucketdz7-3"
    region     = "ru-central1"
    key        = "mystatedz/terraform.tfstate"
    access_key = "	"
	secret_key = "	"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
  
