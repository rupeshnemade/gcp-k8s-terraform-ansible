provider "google" {
credentials = "${file("credentials.json")}"
project = "golden-shine-270312"
region = "us-central1"
}