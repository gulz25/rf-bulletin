# google_compute_subnetwork.subnet1:
resource "google_compute_subnetwork" "subnet-public" {
    ip_cidr_range            = "192.168.10.0/24"
    name                     = "subnet-public"
    network                  = google_compute_network.vpc.name
    private_ip_google_access = true
    project                  = var.project
    region                   = var.region
    timeouts {}
    depends_on = [
    google_compute_network.vpc,
  ]
}
resource "google_compute_subnetwork" "subnet-private" {
    ip_cidr_range            = "192.168.11.0/24"
    name                     = "subnet-private"
    network                  = google_compute_network.vpc.name
    private_ip_google_access = true
    project                  = var.project
    region                   = var.region
    timeouts {}
    depends_on = [
    google_compute_network.vpc,
  ]
}
