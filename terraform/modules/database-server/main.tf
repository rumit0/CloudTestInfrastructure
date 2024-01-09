resource "digitalocean_database_db" "database" {
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = "monolith-db"
}

resource "digitalocean_database_cluster" "postgres" {
  name       = "monolith-db-cluster"
  engine     = "pg"
  version    = "15"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
}

resource "digitalocean_database_firewall" "db-fw" {
  cluster_id = digitalocean_database_cluster.postgres.id

  rule {
    type  = "ip_addr"
    value = "10.0.1.2/32"
  }

  rule {
    type  = "ip_addr"
    value = "0.0.0.0/0"
  }
}