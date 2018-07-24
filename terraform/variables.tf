# -----------------------------------
# Variables with Defaults
# -----------------------------------
variable "container_server_asg_name" {
  description = "The name to assign to the autoscaling group."
  type        = "string"
  default     = "container-server"
}

variable "container_server_asg_max_size" {
  description = "The maximum size of the ASG."
  type        = "string"
  default     = 3
}

variable "container_server_asg_min_size" {
  description = "The minimum size of the ASG."
  type        = "string"
  default     = 3
}

variable "container_server_asg_grace_period" {
  description = "The number of seconds to wait after instance launch before starting health checks."
  type        = "string"
  default     = 30
}

variable "container_server_asg_enabled_metrics" {
  description = "Additional ASG group metrics to enable."
  type        = "string"
  default     = "GroupMinSize,GroupMaxSize,GroupDesiredCapacity,GroupInServiceInstances,GroupPendingInstances,GroupStandbyInstances,GroupTerminatingInstances,GroupTotalInstances"
}

variable "container_server_asg_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start."
  type        = "string"
  default     = 3600
}

variable "container_server_instance_type" {
  description = "The instance type to deploy for container_server instances."
  type        = "string"
  default     = "t2.nano"
}

variable "container_server_consul_tag_key" {
  description = "The tag key for the consul cluster."
  type        = "string"
  default     = "ClusterName"
}

variable "container_server_consul_tag_value" {
  description = "The tag value for the consul cluster."
  type        = "string"
  default     = "cluster-001"
}

variable "cluster_nomad_num" {
  description = "The number of nomad servers in the cluster."
  type        = "string"
  default     = "3"
}

variable "container_server_name_tag_value" {
  description = "The name tag value for the cluster servers."
  type        = "string"
  default     = "ClusterServer"
}

# -----------------------------------
# Variables - Required in tfvars
# -----------------------------------
variable "global_region" {
  description = "The region the infra will be built in."
  type        = "string"
}

variable "my_user" {
  description = "The user running this for access to S3"
  type        = "string"
}

variable "global_vpc_id" {
  description = "The vpc the infra will be built in."
  type        = "string"
}

variable "global_account_id" {
  description = "The account ID the infra will be built in."
  type        = "string"
}

variable "container_server_asg_subnets" {
  description = "Comma-separated string of private subnet IDs in which the ASG should launch resources."
  type        = "string"
}

variable "container_server_ami" {
  description = "The AMI ID to use for the container server host."
  type        = "string"
}
variable "container_worker_ami" {
  description = "The AMI ID to use for the container server host."
  type        = "string"
}

variable "container_server_keypair" {
  description = "The name of the AWS keypair to use when launching instances."
  type        = "string"
}

variable "consul_ssh_ingress" {
  description = "The cidr block for access to the consul ssh."
  type        = "list"
}

variable "consul_ui_ingress" {
  description = "The cidr block for access to the consul interface."
  type        = "list"
}

variable "nomad_ui_ingress" {
  description = "The cidr block for access to the nomad interface."
  type        = "list"
}

variable "transform-bucket" {
  description = "The name of the S3 bucket to use."
  type        = "string"
}
