// Basics
variable "region" {
  default = "asia-northeast1"
}
variable "zone" {
  default = "asia-northeast1-b"
}
variable "project" {
  default = "rf-bulletin"
}
// Resources
variable "domain" {
  default = "rfcommunity.page"
}
variable "prefix" {
  default = "rf-"
}
variable "os" {
  default = "centos-7-v20210122"
}
variable "machine_type_bastion" {
  default = "f1-micro"
}
variable "machine_type_web" {
  default = "e2-small"
}
variable "internal_ip_1" {
  default = "192.168.11.2"
}
variable "internal_ip_2" {
  default = "192.168.11.3"
}
