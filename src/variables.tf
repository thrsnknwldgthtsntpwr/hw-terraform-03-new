###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable vms {
  type = map(object({
    name = string
    cores = number
    ram = number
    core_fraction = number
    image = string
    preemptible = bool
    platform_id = string
    nat = bool  }))
    default = { 
      "web" = {
        name = "web"
        cores = 2
        ram = 1
        core_fraction = 5
        image = "fd833v6c5tb0udvk4jo6"
        preemptible = "true"
        platform_id = "standard-v1"
        nat = "true"
      }
      "storj" = {
        name = "storj"
        cores = 2
        ram = 1
        core_fraction = 5
        image = "fd833v6c5tb0udvk4jo6"
        preemptible = "true"
        platform_id = "standard-v1"
        nat = "true"
      }
    }
}

variable "each_vm" {
  type = list(object({
      vm_name = string
      cpu = number
      ram = number
      disk_volume = number
      core_fraction = number 
      image = string
      preemptible = bool
      platform_id = string
      nat = bool
    }))
    default = [
      {
      vm_name="main"
      cpu = 2
      ram = 2
      disk_volume = 10
      core_fraction = 5 
      image = "fd833v6c5tb0udvk4jo6"
      preemptible = "true"
      platform_id = "standard-v1"
      nat = true
    },
      {
      vm_name="replica"
      cpu = 2
      ram = 2
      disk_volume = 20
      core_fraction = 5 
      image = "fd833v6c5tb0udvk4jo6"
      preemptible = "true"
      platform_id = "standard-v1"
      nat = true
    }
  ]
}