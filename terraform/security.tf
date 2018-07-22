#--------------------------------------------------------------
# Container Server Instance Security Group
#--------------------------------------------------------------
resource "aws_security_group" "container_server" {
  name        = "container-server-"
  description = "The SG for Container Servers"
  vpc_id      = "${var.global_vpc_id}"
}
#--------------------------------------------------------------
# Container Server Instance Security Group SELF Ingress Rules
#--------------------------------------------------------------
resource "aws_security_group_rule" "container_server_allow_self_4646-4648_tcp" {
  type              = "ingress"
  from_port         = 4646
  to_port           = 4648
  protocol          = "tcp"
  self              = true
  security_group_id = "${aws_security_group.container_server.id}"
}

resource "aws_security_group_rule" "container_server_allow_self_4648_udp" {
  type              = "ingress"
  from_port         = 4648
  to_port           = 4648
  protocol          = "udp"
  self              = true
  security_group_id = "${aws_security_group.container_server.id}"
}

resource "aws_security_group_rule" "container_server_allow_self_8300-8302_tcp" {
  type              = "ingress"
  from_port         = 8300
  to_port           = 8302
  protocol          = "tcp"
  self              = true
  security_group_id = "${aws_security_group.container_server.id}"
}

resource "aws_security_group_rule" "container_server_allow_self_8301-8302_udp" {
  type              = "ingress"
  from_port         = 8301
  to_port           = 8302
  protocol          = "udp"
  self              = true
  security_group_id = "${aws_security_group.container_server.id}"
}

#--------------------------------------------------------------
# Container Server Instance Security Group Ingress Rules
#--------------------------------------------------------------
resource "aws_security_group_rule" "container_server_allow_ingress_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = "${var.consul_ssh_ingress}"
  security_group_id        = "${aws_security_group.container_server.id}"
}

resource "aws_security_group_rule" "container_server_allow_ingress_4646" {
  type                     = "ingress"
  from_port                = 4646
  to_port                  = 4646
  protocol                 = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.container_server.id}"
}

resource "aws_security_group_rule" "container_server_allow_ingress_8500" {
  type                     = "ingress"
  from_port                = 8500
  to_port                  = 8500
  protocol                 = "tcp"
  cidr_blocks              = "${var.consul_ui_ingress}"
  security_group_id        = "${aws_security_group.container_server.id}"
}

#--------------------------------------------------------------
# Container Server Instance Security Group Egress Rules
#--------------------------------------------------------------
resource "aws_security_group_rule" "container_consul_allow_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.container_server.id}"
}
