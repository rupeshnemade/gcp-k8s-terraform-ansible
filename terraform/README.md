# Using GCP and Terraform

## Usage
### Running and getting up
After installing terraform and configuring google cloud account. We have to run application using `terraform`.


1. **terraform commands**
  * `terraform init`
     This command sets up the environment.

  * `terraform plan`
     This command reports configuration will be applied.
  
  * `terraform apply -auto-approve`
     This command applies configuration defined on terraform files approving automatically changes.

  * `terraform destroy -auto-approve`
     Against of command above, this remove everything created.