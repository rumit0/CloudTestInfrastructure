data "digitalocean_ssh_key" "ssh_key" {
  name = "temp"
#   fingerprint = var.ssh_key_fingerprint
}

resource "digitalocean_vpc" "network" {
  name     = "main-network"
  ip_range = "10.0.0.0/16"
  region = "fra1"
}

module "api_server_1" {
  source = "./modules/api-server"

  name = "api1"
  location = "hel1"
  server_type = "cx21"
  image = "ubuntu-22.04"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.name]
  network_id = digitalocean_vpc.network.id
}

module "api_server_2" {
  source = "./modules/api-server"

  name = "api2"
  location = "hel1"
  server_type = "cx21"
  image = "ubuntu-22.04"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.name]
  network_id = digitalocean_vpc.network.id
}

module "worker_server_1" {
  source = "./modules/worker-server"

  name = "worker1"
  location = "hel1"
  server_type = "cx21"
  image = "ubuntu-22.04"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.name]
  network_id = digitalocean_vpc.network.id
  volume_size = 40
}

module "worker_server_2" {
  source = "./modules/worker-server"

  name = "worker2"
  location = "hel1"
  server_type = "cx21"
  image = "ubuntu-22.04"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.name]
  network_id = digitalocean_vpc.network.id
  volume_size = 40
}

module "worker_server_3" {
  source = "./modules/worker-server"

  name = "worker3"
  location = "hel1"
  server_type = "cx21"
  image = "ubuntu-22.04"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.name]
  network_id = digitalocean_vpc.network.id
  volume_size = 40
}

module "worker_server_4" {
  source = "./modules/worker-server"

  name = "worker4"
  location = "hel1"
  server_type = "cx21"
  image = "ubuntu-22.04"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.name]
  network_id = digitalocean_vpc.network.id
  volume_size = 40
}