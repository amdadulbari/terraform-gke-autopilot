variable "credentials_file" {
  description = "The GCP credentials file"
  type        = string
  default     = "imad-the-devops.json"
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "imadthedevops"
}

variable "region" {
  description = "The GCP region to deploy resources in"
  default     = "asia-southeast1"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "gke-autopilot-vpc-imad"
}

variable "subnet_name" {
  description = "Name of the subnet"
  default     = "gke-autopilot-subnet-imad"
}

variable "subnet_cidr" {
  description = "CIDR for the subnet"
  default     = "10.0.0.0/24"
}
variable "pods_secondary_range_name" {
  description = "The name of the secondary range to use for pods"
  default     = "pods-range"
}

variable "services_secondary_range_name" {
  description = "The name of the secondary range to use for services"
  default     = "services-range"
}
