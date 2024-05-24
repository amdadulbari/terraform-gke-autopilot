# GKE Autopilot Cluster Terraform Configuration

This repository contains the Terraform configurations necessary to deploy a Google Kubernetes Engine (GKE) Autopilot cluster along with the required network infrastructure within Google Cloud Platform (GCP).

## Overview

The Terraform scripts in this repository will set up the following resources in GCP:

- A Virtual Private Cloud (VPC) network.
- A subnet within the VPC with custom secondary ranges for pods and services.
- A Google Compute Router and a NAT configuration with a dedicated static IP for outgoing connections.
- A GKE Autopilot cluster configured to run within the defined VPC and subnet, utilizing private IPs for enhanced security.

## Prerequisites

Before you begin, ensure you have the following:

- A Google Cloud Platform account.
- Installed Google Cloud SDK and configured access credentials.
- Installed Terraform CLI (0.12.x or later).

## Usage

Follow these steps to deploy the GKE Autopilot cluster using Terraform:

### 1. Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/amdadulbari/terraform-gke-autopilot.git
cd terraform-gke-autopilot
```
### Initialize Terraform
```
terraform init
```
### Review the Terraform Plan
```
terraform plan
```
### Apply the Configuration
```
terraform apply
```
### Outputs
After applying the Terraform configuration, the outputs will include:

* The name and endpoint of the GKE Autopilot cluster.
* The name of the VPC and subnet created.
* The public IP address used for the NAT gateway.