resource "google_compute_instance" "rf-jumphost" {
    machine_type         = var.machine_type_bastion
    name                 = "${var.prefix}jumphost"
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
        network            = "${var.prefix}vpc"
        network_ip         = "192.168.10.10"
        subnetwork         = "${var.prefix}subnet-public"
        subnetwork_project = var.project
        access_config {
//            network_tier = "STANDARD"
        }
    }
    scheduling {
        automatic_restart   = true
        on_host_maintenance = "MIGRATE"
    }
    timeouts {}
    depends_on = [
    google_compute_subnetwork.rf-subnet-public,
  ]
}
resource "google_compute_instance" "rf-web" {
    machine_type         = var.machine_type_web
    name                 = "${var.prefix}web"
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
    }
    network_interface {
        network            = "${var.prefix}vpc"
        network_ip         = var.internal_ip_1
        subnetwork         = "${var.prefix}subnet-private"
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
        google_compute_subnetwork.rf-subnet-private,
  ]
}
