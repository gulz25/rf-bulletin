locals {
    prod = {
        default = {
        instance_name       = ""
        machine_type        = "e2-small"
        bootdisk_size       = 100
        ip          = "192.168.11.2"
      }
    stg = {
        instance_name       = ""
        machine_type        = "f1-micro"
        bootdisk_size       = 100
        ip          = "192.168.11.3"
      }
    }
}
# google_compute_instance.rf-jumphost:
resource "google_compute_instance" "rf-jumphost" {
    can_ip_forward       = false
    deletion_protection  = false
    enable_display       = false
    labels               = {}
    machine_type         = "f1-micro"
    metadata             = {}
    name                 = "rf-jumphost${local.prod[terraform.workspace].instance_name}"
    project              = "rf-bulletin"
    tags                 = [
        "public",
    ]
    zone                 = "asia-northeast1-b"
    boot_disk {
        auto_delete = true
        device_name = "rf-jumphost-boot-disk"
        mode        = "READ_WRITE"

        initialize_params {
            image  = "centos-7-v20210122"
            labels = {}
            size   = local.prod[terraform.workspace].bootdisk_size
            type   = "pd-standard"
        }
    }
    network_interface {
        network            = "rf-vpc"
        network_ip         = "192.168.10.10"
        subnetwork         = "rf-subnet-public"
        subnetwork_project = "rf-bulletin"

        access_config {
            network_tier = "STANDARD"
        }
    }
    scheduling {
        automatic_restart   = true
        on_host_maintenance = "MIGRATE"
        preemptible         = false
    }
    shielded_instance_config {
        enable_integrity_monitoring = true
        enable_secure_boot          = false
        enable_vtpm                 = true
    }
    timeouts {}
    depends_on = [
    google_compute_subnetwork.rf-subnet-public,
  ]
}

# google_compute_instance.rf-osclass:
resource "google_compute_instance" "rf-osclass" {
    can_ip_forward       = false
    deletion_protection  = false
    enable_display       = false
    labels               = {}
    machine_type         = local.prod[terraform.workspace].machine_type
    metadata             = {}
    name                 = "rf-osclass${local.prod[terraform.workspace].instance_name}"
    project              = "rf-bulletin"
    metadata_startup_script = file("./scripts/bootstrap.sh")
    tags                 = [
        "private",
    ]
    zone                 = "asia-northeast1-b"
    boot_disk {
        auto_delete = true
        device_name = "rf-osclass-boot-disk"
        mode        = "READ_WRITE"
        initialize_params {
            image  = "centos-7"
            labels = {}
            size   = local.prod[terraform.workspace].bootdisk_size
            type   = "pd-standard"
        }
    }
    network_interface {
        network            = "rf-vpc"
        network_ip         = local.prod[terraform.workspace].ip
        subnetwork         = "rf-subnet-private"
        subnetwork_project = "rf-bulletin"
    }
    scheduling {
        automatic_restart   = true
        on_host_maintenance = "MIGRATE"
        preemptible         = false
    }
    shielded_instance_config {
        enable_integrity_monitoring = true
        enable_secure_boot          = false
        enable_vtpm                 = true
    }
    timeouts {}
    depends_on = [
        google_compute_subnetwork.rf-subnet-private,
  ]
}
resource "google_compute_instance" "rf-joomla" {
    can_ip_forward       = false
    deletion_protection  = false
    enable_display       = false
    labels               = {}
    machine_type         = local.prod[terraform.workspace].machine_type
    metadata             = {}
    name                 = "rf-joomla"
    project              = "rf-bulletin"
    metadata_startup_script = file("./scripts/bootstrap.sh")
    tags                 = [
        "private",
    ]
    zone                 = "asia-northeast1-b"
    boot_disk {
        auto_delete = true
        device_name = "rf-joomla-boot-disk"
        mode        = "READ_WRITE"
        initialize_params {
            image  = "centos-7"
            labels = {}
            size   = 100
            type   = "pd-standard"
        }
    }
    network_interface {
        network            = "rf-vpc"
        network_ip         = "192.168.11.3"
        subnetwork         = "rf-subnet-private"
        subnetwork_project = "rf-bulletin"
    }
    scheduling {
        automatic_restart   = true
        on_host_maintenance = "MIGRATE"
        preemptible         = false
    }
    shielded_instance_config {
        enable_integrity_monitoring = true
        enable_secure_boot          = false
        enable_vtpm                 = true
    }
    timeouts {}
    depends_on = [
        google_compute_subnetwork.rf-subnet-private,
  ]
}
