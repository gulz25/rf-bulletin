// Configure the Google Cloud provider
provider "google" {
//  credentials = var.service_account
  project     = var.project
  region      = var.region
}
