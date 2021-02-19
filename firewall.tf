resource "google_compute_firewall" "allow-ssh-wfh" {
  name    = "allow-ssh-wfh"
  network = google_compute_network.vpc.name
  description = "allows ssh connections from home"
  source_ranges = ["115.179.53.70/32"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["public"]
  depends_on = [
    google_compute_network.vpc,
  ]
}
resource "google_compute_firewall" "allow-http-https" {
  name    = "allow-http-https"
  network = google_compute_network.vpc.name
  description = "allows http/https access from home"
//  source_ranges = ["115.179.53.70/32"]
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["80","443","8000","8080"]
  }
  target_tags = ["private"]
  depends_on = [
    google_compute_network.vpc,
  ]
}
resource "google_compute_firewall" "allow-rfbulletin-internal" {
  name    = "allow-rfbulletin-internal"
  network = google_compute_network.vpc.name
  description = "allows internal connections within private subnet"
  source_ranges = ["192.168.10.0/24","192.168.11.0/24"]
  allow {
    protocol = "all"
  }
  target_tags = ["public","private"]
  depends_on = [
    google_compute_network.vpc,
  ]
}
