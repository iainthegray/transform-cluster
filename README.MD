# transform-cluster

## Overview
A repo to demonstrate the capabilities of a number of Hashicorp's products:
* Packer - Used to build specific AMIs for the project
* Terraform - Used to deploy infrastructure to AWS
* Consul - Used as a service discovery layer for the cluster
* Nomad - Used as a scheduler for batch job delivery

The project delivers a nomad cluster and demonstrates its use as a batch job scheduler, anonymising email texts using piiregex library
https://github.com/Poogles/piiregex

### Cluster Sizing

Consul requires a quorum to perform correctly and Hashicorp advise that the recommended configuration is to either run 3 or 5 Consul servers per datacenter. It is possible to run 7 Consul servers providing the network latency is low, however, you should never go above this number. The Hashicorp [deployment table](https://www.consul.io/docs/internals/consensus.html#deployment_table) provides some additional information if required.

### Instance Sizing

For testing purposes the default value of `t2.micro` is more than adequate. Additional testing is required to provide details on sensible production setups with workload estimates.

### Security
The terraform code in this repo is most definitely **NOT SAFE FOR PRODUCTION**

* There is no supporting infrastructure such as an [E|A]LB
* There is no TLS on anything
* The nomad worker node has a role on it to allow it to read/write to the S3 bucket. This is not secure as all jobs on the node would inherit this role. A better way would be to provide API keys via Vault.

## Dependencies

This module makes the following assumptions:
* You have a functioning VPC in AWS
* You have these ENVARS set up to allow AWS access (or other method):
  * AWS_ACCESS_KEY_ID
  * AWS_SECRET_ACCESS_KEY
  * AWS_DEFAULT_REGION

## Further Improvements
__Automatic job Dispatch__ - The jobs should use a further piece of infrastructure (AWS Lambda) that triggers on an S3 event when new files are added to the source folder.

__Vault Integration__ - As mentioned in security section, The S3 permissions would benefit from utilising Vault to take API keys rather than having a role on the worker node to limit access to only jobs that need it.
