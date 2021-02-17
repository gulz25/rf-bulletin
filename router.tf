resource "google_compute_router" "cloud-router" {
  name    = "${var.prefix}-cloud-router"
  region  = "asia-northeast1"
  network = "${var.prefix}-vpc"
  timeouts {}
  depends_on = [
    google_compute_subnetwork.subnet-public,
    google_compute_subnetwork.subnet-private,
  ]
}
resource "google_compute_router_nat" "cloud-router-nat" {
  name                               = "${var.prefix}-cloud-nat"
  router                             = "${var.prefix}-cloud-router"
  region                             = "asia-northeast1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name = "${var.prefix}-subnet-private"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  timeouts {}
  depends_on = [
    google_compute_router.cloud-router,
  ]
}
