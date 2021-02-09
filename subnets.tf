# google_compute_subnetwork.rf-subnet1:
resource "google_compute_subnetwork" "rf-subnet-public" {
    ip_cidr_range            = "192.168.10.0/24"
    name                     = "rf-subnet-public"
    network                  = "rf-vpc"
    private_ip_google_access = true
    project                  = "rf-bulletin"
    region                   = "asia-northeast1"
    secondary_ip_range       = []
    timeouts {}
    depends_on = [
    google_compute_network.rf-vpc,
  ]
}
resource "google_compute_subnetwork" "rf-subnet-private" {
    ip_cidr_range            = "192.168.11.0/24"
    name                     = "rf-subnet-private"
    network                  = "rf-vpc"
    private_ip_google_access = true
    project                  = "rf-bulletin"
    region                   = "asia-northeast1"
    secondary_ip_range       = []
    timeouts {}
    depends_on = [
    google_compute_network.rf-vpc,
  ]
}
