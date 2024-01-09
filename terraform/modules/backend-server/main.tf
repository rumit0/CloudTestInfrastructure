resource "digitalocean_droplet" "api" {
  name   = "backend-server"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-20-04-x64"
  region = "fra1"
}

resource "digitalocean_firewall" "api" {
  name = "backend-firewall"

  droplet_ids = [digitalocean_droplet.api.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["10.0.1.1/32"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "80"
    source_addresses = ["10.0.1.1/32"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["10.0.1.1/32"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "443"
    source_addresses = ["10.0.1.1/32"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "5432"
    destination_addresses = ["10.0.1.3/32"]
  }
}