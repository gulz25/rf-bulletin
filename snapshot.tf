resource "google_compute_resource_policy" "snapshot" {
  name   = "snapshot"
  region = "asia-northeast1"
  snapshot_schedule_policy {
    schedule {
      weekly_schedule {
        day_of_weeks {
            start_time  = "03:00"
            day         = "WEDNESDAY"
        }
      }
    }
    retention_policy {
      max_retention_days    = 14
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
    snapshot_properties {
      storage_locations = ["asia"]
    }
  }
}
