# google_compute_subnetwork.rf-subnet1:
resource "google_compute_subnetwork" "rf-subnet-public" {
    ip_cidr_range            = "192.168.10.0/24"
    name                     = "${var.prefix}subnet-public"
    network                  = "${var.prefix}vpc"
    private_ip_google_access = true
    project                  = var.project
    region                   = var.region
    timeouts {}
    depends_on = [
    google_compute_network.rf-vpc,
  ]
}
resource "google_compute_subnetwork" "rf-subnet-private" {
    ip_cidr_range            = "192.168.11.0/24"
    name                     = "${var.prefix}subnet-private"
    network                  = "${var.prefix}vpc"
    private_ip_google_access = true
    project                  = var.project
    region                   = var.region
    timeouts {}
    depends_on = [
    google_compute_network.rf-vpc,
  ]
}
