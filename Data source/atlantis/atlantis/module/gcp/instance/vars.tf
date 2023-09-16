variable "project" {
  type = string
  description = "variable untuk project GCP"
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "credentials" {
  type = string
}

variable "name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "tags" {
  type = list
}

variable "image" {
  type = string
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}