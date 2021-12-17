provider "google" {
  project = "{var.gcp_project}"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_pubsub_topic" "mytopic" {
  name = "${var.pub_sub_name}"
}

resource "google_storage_bucket" "bucket" {
  name = "${var.bucket_name}"
}

resource "google_storage_bucket_object" "archive" {
  name   = "function.zip"
  bucket = "${google_storage_bucket.bucket.name}"
  source = "./function/function.zip"
}

resource "google_cloudfunctions_function" "function" {
  name                  = "${var.lambda_name}"
  description           = "reads in pub_sub and prints to stdout"
  available_memory_mb   = 128
  source_archive_bucket = "${google_storage_bucket.bucket.name}"
  source_archive_object = "${google_storage_bucket_object.archive.name}"

  event_trigger = {
    event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource   = "${google_pubsub_topic.mytopic.name}"
  }

  timeout     = 80
  entry_point = "hello_pubsub"

  labels {
    my-label = "example_project"
  }

  environment_variables {
    PUB_SUB_NAME = "${google_pubsub_topic.mytopic.name}"
  }
}
