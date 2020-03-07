resource "google_compute_instance" "default" {
  name         = "test-webserver"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

    // Apply the firewall rule to allow external IPs to access this instance
    tags = ["http-server"]
}

resource "google_compute_firewall" "http-server" {
  name    = "default-allow-http-terraform"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  // Allow traffic from below IP to instances with an http-server tag
  source_ranges = ["104.56.114.248/32","183.87.60.250/32"]
  target_tags   = ["http-server"]
}

resource "null_resource" "deploy" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible/inv.gcp.yml ../ansible/test.yml"
  }
}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}