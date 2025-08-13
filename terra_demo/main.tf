terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.47.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
}


resource "google_storage_bucket" "demo-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  # lifecycle_rule {
  #   condition {
  #     age = 3
  #   } #Tự động xóa (Delete) các object trong bucket sau 3 ngày
  #   action {
  #     type = "Delete"
  #   }
  # }
  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
    #Hủy các upload multipart chưa hoàn thành sau 1 ngày
  }
}


resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}
