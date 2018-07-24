## Terraform
The terraform is split into several files for ease of use. Each file detailing a different resource.

### Required Input Variables
* `global_region` - The region the infra will run in
* `my_user` - The user running this for access to S3
* `global_vpc_id` - The vpc the infra will be built in.
* `global_account_id` - The account ID the infra will be built in.
* `container_server_ami` - The AMI ID to use for the container server host. (from the packer build)
* `container_worker_ami` - The AMI ID to use for the container server host.  (from the packer build)
* `container_server_asg_subnets` - Comma-separated string of private subnet IDs in which the ASG should launch resources. (as a string just to show string splitting)
* `container_server_keypair` - The name of the AWS keypair to use when launching instances.
* `consul_ssh_ingress` - The list of cidr block for access to the consul ssh.
* `consul_ui_ingress` - The list of cidr block for access to the consul ui.
* `nomad_ui_ingress` - The list of cidr block for access to the nomad ui.
* `transform-bucket` - The name of the S3 bucket to create.

### Optional Input Variables
* `container_server_asg_name` - The name to assign to the autoscaling group
* `container_server_asg_max_size` - The maximum size of the ASG.
* `container_server_asg_min_size` - The minimum size of the ASG. * `container_server_asg_grace_period` - The number of seconds to wait after instance launch before starting health checks.
* `container_server_asg_enabled_metrics` - Additional ASG group metrics to enable
* `container_server_asg_cooldown` - The amount of time, in seconds, after a scaling activity completes before another scaling activity can start
* `container_server_instance_type` - The instance type to deploy for container_server instances
* `container_server_consul_tag_key` - The tag key for the consul cluster.
* container_server_consul_tag_value - The tag value for the consul cluster.
* `cluster_nomad_num` - The number of nomad servers in the cluster.
* `container_server_name_tag_value` - The name tag value for the cluster servers.
