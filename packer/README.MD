## Packer
The packer scripts are in the packer directory. There are 2 separate AMI creation scripts: 1 for the servers and 1 for the workers.
The install-scripts for nomad and consul were sourced from:
- https://github.com/hashicorp/terraform-aws-nomad
- https://github.com/hashicorp/terraform-aws-consul

They have been modified to suit this install and fix an issue with the worker joining the cluster

All variables are declared at the top of each packer file.

There are 2 packer files:
* nomad-consul.json
  * This builds the nomad/consul server AMI
  * Name will be nomad-consul[timestamp]
* nomad-worker.json
  * This builds the nomad-worker servers
  * Name will be nomad-worker[timestamp]

### Build Commands
`packer build [json file]`

Once the AMIs are built the AMIs should be referenced in terraform.tfvars as:
* container_server_ami
* container_worker_ami
