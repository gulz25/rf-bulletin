# google_compute_network.vpc:
resource "google_compute_network" "vpc" {
    auto_create_subnetworks         = false
    delete_default_routes_on_create = false
    description                     = "for private rf bulletin project"
    name                            = "vpc"
    project                         = var.project
    routing_mode                    = "REGIONAL"

    timeouts {}
}
