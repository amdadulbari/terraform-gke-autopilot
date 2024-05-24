resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.27.0.0/17"
  }

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.28.128.0/18"
  }
}

resource "google_compute_router" "router" {
  name    = "${var.vpc_name}-router"
  region  = var.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = "${var.vpc_name}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  nat_ips = [google_compute_address.static_ip.self_link]

  subnetwork {
    name                    = google_compute_subnetwork.subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_compute_address" "static_ip" {
  name   = "gke-autopilot-static-ip"
  region = var.region
}

output "static_ip_address" {
  value = google_compute_address.static_ip.address
}


output "vpc_network_name" {
  value = google_compute_network.vpc_network.name
}

output "subnet_name" {
  value = google_compute_subnetwork.subnet.name
}

output "router_name" {
  value = google_compute_router.router.name
}

output "nat_gateway_name" {
  value = google_compute_router_nat.nat_gateway.name
}

resource "google_container_cluster" "autopilot_cluster" {
  name               = "autopilot-cluster-1"
  location           = var.region
  network            = google_compute_network.vpc_network.id
  subnetwork         = google_compute_subnetwork.subnet.name
  initial_node_count = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  release_channel {
    channel = "REGULAR"
  }

  networking_mode = "VPC_NATIVE"

  enable_autopilot = true
}


output "cluster_name" {
  value = google_container_cluster.autopilot_cluster.name
}

output "cluster_endpoint" {
  value = google_container_cluster.autopilot_cluster.endpoint
}

output "cluster_master_version" {
  value = google_container_cluster.autopilot_cluster.master_version
}
