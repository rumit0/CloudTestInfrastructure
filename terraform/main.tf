data "digitalocean_ssh_key" "ssh_key" {
  name = "temp"
}

resource "digitalocean_vpc" "network" {
  name     = "main-network"
  ip_range = "10.0.0.0/16"
  region = "fra1"
}

module "backendserver" {
  source = "./modules/backend-server"

  name = "monolith-backend"
  location = "fra1"
  server_type = "cx21"
  image = "ubuntu-22.04"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.name]
  network_id = digitalocean_vpc.network.id
}

module "frontendserver" {
  source = "./modules/frontend-server"

  name = "monolith-frontend"
  location = "fra1"
  server_type = "cx21"
  image = "ubuntu-22.04"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.name]
  network_id = digitalocean_vpc.network.id
  volume_size = 40
}

module "databaseserver" {
  source="./modules/database-server"
  
  name = "monolith-db"
  location = "fra1"
  server_type = "cx21"
  image = "ubuntu-22.04"
  ssh_keys = [data.digitalocean_ssh_key.ssh_key.name]
  network_id = digitalocean_vpc.network.id
  volume_size = 40
}