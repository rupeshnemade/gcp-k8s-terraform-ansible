provider "google" {
credentials = "${file("credentials.json")}"
project = "devops-challenge"
region = "us-central1"
}