## Packer
The packer scripts are in the packer directory. There are 2 separate AMI creation scripts: 1 for the servers and 1 for the workers.
The install-scripts for nomad and consul were sourced from:
- https://github.com/hashicorp/terraform-aws-nomad
- https://github.com/hashicorp/terraform-aws-consul

They have been modified to suit this install.

All variables are declared at the top of each packer file.
