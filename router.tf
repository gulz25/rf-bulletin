resource "google_compute_router" "cloud-router" {
  name    = "cloud-router"
  region  = var.region
  network = google_compute_network.vpc.name
  timeouts {}
  depends_on = [
    google_compute_subnetwork.subnet-public,
    google_compute_subnetwork.subnet-private,
  ]
}
resource "google_compute_router_nat" "cloud-router-nat" {
  name                               = "cloud-nat"
  router                             = google_compute_router.cloud-router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name = google_compute_subnetwork.subnet-private.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  timeouts {}
  depends_on = [
    google_compute_router.cloud-router,
  ]
}
