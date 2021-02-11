# google_compute_network.rf-vpc:
resource "google_compute_network" "rf-vpc" {
    auto_create_subnetworks         = false
    delete_default_routes_on_create = false
    description                     = "for private rf bulletin project"
    name                            = "${var.prefix}vpc"
    project                         = var.project
    routing_mode                    = "REGIONAL"

    timeouts {}
}
