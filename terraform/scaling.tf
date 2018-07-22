#---------------------------------------------------------------
# Auto Scaling Group to run Consul/Nomad
#---------------------------------------------------------------
resource "aws_autoscaling_group" "container_server" {
  name                      = "${var.container_server_asg_name}"
  vpc_zone_identifier       = ["${split(",", var.container_server_asg_subnets)}"]
  launch_configuration      = "${aws_launch_configuration.container_server.id}"
  max_size                  = "${var.container_server_asg_max_size}"
  min_size                  = "${var.container_server_asg_min_size}"
  health_check_type         = "EC2"
  health_check_grace_period = "${var.container_server_asg_grace_period}"
  enabled_metrics           = ["${split(",", var.container_server_asg_enabled_metrics)}"]
  default_cooldown          = "${var.container_server_asg_cooldown}"
  tag {
    key                = "ClusterName"
    value              = "${var.container_server_consul_tag_value}"
    propagate_at_launch = "true"
  }
  tag {
    key                = "Name"
    value              = "${var.container_server_name_tag_value}"
    propagate_at_launch = "true"
  }
  lifecycle {
    create_before_destroy = true
  }
}

#---------------------------------------------------------------
# Container Server Launch Configuration
#---------------------------------------------------------------
resource "aws_launch_configuration" "container_server" {
  name_prefix          = "container-server-"
  image_id             = "${var.container_server_ami}"
  instance_type        = "${var.container_server_instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.container_server.id}"
  key_name             = "${var.container_server_keypair}"

  security_groups = ["${aws_security_group.container_server.id}"]
  user_data       = "${data.template_file.container_server_user_data.rendered}"
  lifecycle {
    create_before_destroy = true
  }
}
