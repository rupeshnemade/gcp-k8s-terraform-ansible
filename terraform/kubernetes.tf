variable "location" {
  default     = "us-central1-a"
  description = "region (us-central1) or zone (us-central1-a)"
  type        = "string"
}

resource "google_container_cluster" "k8s-cluster" {
  name                     = "devops-challenge"
  remove_default_node_pool = true

  location = "${var.location}"

  master_auth {
    username = ""
    password = ""
  }

  logging_service    = "none"
  monitoring_service = "none"

  addons_config {
    http_load_balancing {
      disabled = true
    }
  }

  initial_node_count = 1
}

resource "google_container_node_pool" "worker" {
  name       = "worker"
  location   = "${var.location}"
  cluster    = "${google_container_cluster.k8s-cluster.name}"
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

output "cluster_name" {
  value = "${google_container_cluster.k8s-cluster.name}"
}

output "location" {
  value = "${google_container_cluster.k8s-cluster.location}"
}