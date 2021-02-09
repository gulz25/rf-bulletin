resource "google_compute_router" "rf-cloud-router" {
  name    = "rf-cloud-router"
  region  = "asia-northeast1"
  network = "rf-vpc"
  timeouts {}
  depends_on = [
    google_compute_subnetwork.rf-subnet-public,
    google_compute_subnetwork.rf-subnet-private,
  ]
}
resource "google_compute_router_nat" "rf-cloud-router-nat" {
  name                               = "rf-cloud-nat"
  router                             = "rf-cloud-router"
  region                             = "asia-northeast1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name = "rf-subnet-private"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  timeouts {}
  depends_on = [
    google_compute_router.rf-cloud-router,
  ]
}
