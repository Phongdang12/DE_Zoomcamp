variable "credentials" {
  description = "My Credentials"
  default     = "./keys/my-creds.json"
}

variable "project" {
  description = "Project"
  default     = "terraform-demo-468612"
}

variable "location" {
  description = "The location for the Google Cloud resources"
  default     = "US"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}


variable "bq_dataset_name" {
  description = "The name of the BigQuery dataset"
  default     = "demo_dataset"
}
variable "gcs_storage_class" {
  description = "The storage class for the Google Cloud Storage bucket"
  default     = "STANDARD"
}
variable "gcs_bucket_name" {
  description = "My GCS bucket name"
  default     = "terraform-demo-468612-terra-bucket"
}