resource "google_compute_instance" "jumphost" {
    machine_type         = var.machine_type_bastion
    name                 = "${var.prefix}-jumphost"
    project              = var.project
    tags                 = [
        "public",
    ]
    zone                 = var.zone
    boot_disk {
        initialize_params {
            image  = var.os
            size   = 100
            type   = "pd-standard"
        }
    }
    network_interface {
        network            = google_compute_network.vpc.name
        network_ip         = var.internal_ip_1
        subnetwork         = google_compute_subnetwork.subnet-public.name
        subnetwork_project = var.project
        access_config {
        }
    }
    scheduling {
        automatic_restart   = true
        on_host_maintenance = "MIGRATE"
    }
    timeouts {}
    depends_on = [
        google_compute_subnetwork.subnet-public,
  ]
}
resource "google_compute_instance" "web" {
    machine_type         = var.machine_type_web
    name                 = "${var.prefix}-web"
    project              = var.project
    metadata_startup_script = file("./scripts/bootstrap.sh")
    tags                 = [
        "private",
    ]
    zone                 = var.zone
    boot_disk {
        mode        = "READ_WRITE"
        initialize_params {
            image  = var.os
            size   = 100
            type   = "pd-standard"
        }
#        source = "https://www.googleapis.com/compute/v1/projects/rf-bulletin/global/snapshots/snapshot-1"
    }
    network_interface {
        network            = google_compute_network.vpc.name
        network_ip         = var.internal_ip_2
        subnetwork         = google_compute_subnetwork.subnet-private.name
        subnetwork_project = var.project
        access_config {
            nat_ip = google_compute_address.web1.address
        }
    }
    scheduling {
        automatic_restart   = true
        on_host_maintenance = "MIGRATE"
    }
    timeouts {}
    depends_on = [
        google_compute_subnetwork.subnet-private,
  ]
}
