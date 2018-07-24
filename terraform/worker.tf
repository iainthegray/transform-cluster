#---------------------------------------------------------------
# worker node
#---------------------------------------------------------------
resource "aws_instance" "worker" {
  ami                  = "${var.container_worker_ami}"
  instance_type        = "t2.nano"
  user_data            = "${data.template_file.container_worker_user_data.rendered}"
  security_groups      = ["${aws_security_group.container_server.name}"]
  key_name             = "${var.container_server_keypair}"
  iam_instance_profile = "${aws_iam_instance_profile.container_server.id}"

  tags {
    Name        = "WorkerNode"
    ClusterName = "${var.container_server_consul_tag_value}"
  }
}
