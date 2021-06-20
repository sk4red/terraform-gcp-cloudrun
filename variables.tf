# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator.
# ---------------------------------------------------------------------------------------------------------------------

variable "project" {
  description = "The project ID where all resources will be launched."
  type        = string
}

variable "location" {
  description = "The location (region or zone) to deploy the Cloud Run services. Note: Be sure to pick a region that supports Cloud Run."
  type        = string
}

variable "gcr_region" {
  description = "Name of the GCP region where the GCR registry is located. e.g: 'us' or 'eu'."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

variable "service_name" {
  description = "The name of the Cloud Run service to deploy."
  type        = string
  default     = "furmidge-bls"
}

variable "repository_name" {
  description = "Name of the Google Cloud Source Repository to create."
  type        = string
  default     = "blazorshop"
}

variable "image_name" {
  description = "The name of the image to deploy. Defaults to a publically available image."
  type        = string
  default     = "gcr.io/atos-cloudrun-demo/blazorshop"
}

variable "branch_name" {
  description = "Example branch name used to trigger builds."
  type        = string
  default     = "master"
}

variable "digest" {
  description = "The docker image digest or tag to deploy."
  type        = string
  default     = "latest"
}

variable "deploy_db" {
  description = "Whether to deploy a Cloud SQL database or not."
  type        = bool
  default     = true
}

variable "db_instance_name" {
  description = "The name of the Cloud SQL database instance."
  type        = string
  default     = "furmidge-atos-cloudrun-demo"
 
}

variable "db_name" {
  description = "The name of the Cloud SQL database."
  type        = string
  default     = "furmidge_mysqldb"
}

variable "db_username" {
  description = "The name of the Cloud SQL database user."
  type        = string
  default     = "furmidge_adm"
}

variable "db_user_host" {
  description = "The host of the Cloud SQL database user. Used by MySQL."
  type        = string
  default     = "%"
}
variable "cloud_provider" {
  description = "The cloud platform"
  type        = string
  default     = "GCP"
}