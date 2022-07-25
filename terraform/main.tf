
provider "yandex" {
  token     = "AQAAAAAJiZIeAATuwUekbj_OnU6Dgt8lAdH2cFc"
  cloud_id  = "b1g1q5rskild90n5b9n4"
  folder_id = "b1gq945akrsqbn63337t"
  zone      = "ru-central1-a"
}


resource "yandex_storage_bucket" vagatestdz73 {
  access_key = "YCAJEgtXjxD6w-71KYS3A8RI7"
  secret_key = "YCOFFm9qPgoQSSzP1phXFUtZdcRMO8Ta8hKEjsAA"
  bucket = "bucketdz7-3"
}
  