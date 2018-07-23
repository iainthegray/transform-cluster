#--------------------------------------------------------------
# Container Server IAM Role and Policy
#--------------------------------------------------------------
resource "aws_iam_instance_profile" "container_server" {
  name = "container-server-${var.global_region}"
  role = "${aws_iam_role.container_server.name}"
}

resource "aws_iam_role" "container_server" {
  name               = "container-server-${var.global_region}"
  path               = "/"
  assume_role_policy = "${file("provisioning/files/container-server-role.json")}"
}

resource "aws_iam_role_policy" "container_server" {
  name   = "container-server-${var.global_region}"
  role   = "${aws_iam_role.container_server.id}"
  policy = "${data.template_file.container_server_iam_policy.rendered}"
}

#--------------------------------------------------------------
# S3 IAM Role and Policy
#--------------------------------------------------------------
resource "aws_iam_role_policy" "s3-access" {
  name   = "s3-access-${var.global_region}"
  role   = "${aws_iam_role.container_server.id}"
  policy = "${data.template_file.s3_iam_policy.rendered}"
}

#--------------------------------------------------------------
# IAM user access to S3
#--------------------------------------------------------------
resource "aws_iam_user_policy" "desktop-access" {
  name   = "desk-access"
  user   = "${var.my_user}"
  policy = "${data.template_file.s3_iam_policy.rendered}"
}
