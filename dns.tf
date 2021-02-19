resource "google_dns_managed_zone" "dns-zone" {
  name          = "dns-zone"
  dns_name      = "${var.domain}."
  visibility    = "public"
}
resource "google_dns_record_set" "domain" {
  name      = google_dns_managed_zone.dns-zone.dns_name
  type      = "A"
  ttl       = 300
  managed_zone = google_dns_managed_zone.dns-zone.name
  rrdatas = [ google_compute_address.web1.address ]
  depends_on = [ google_dns_managed_zone.dns-zone, ]
}
resource "google_dns_record_set" "cname" {
  name      = "www.${google_dns_managed_zone.dns-zone.dns_name}"
  type      = "CNAME"
  ttl       = 300
  managed_zone = google_dns_managed_zone.dns-zone.name
  rrdatas = [ "${var.domain}." ]
  depends_on = [ google_dns_managed_zone.dns-zone, ]
}

## DO NOT FORGET TO CONFIGURE THE NAME SERVERS OF THE DOMAIN REGISTRAR.
