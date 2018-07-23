#--------------------------------------------------------------
# Container Server IAM Policy
#--------------------------------------------------------------
data "template_file" "container_server_iam_policy" {
  template = "${file("provisioning/templates/container-server-role-policy.json.tpl")}"
}

data "template_file" "s3_iam_policy" {
  template = "${file("provisioning/templates/s3-access-role.json.tpl")}"

  vars {
    s3-bucket-name = "${var.transform-bucket}"
  }
}

#--------------------------------------------------------------
# Container Server User Data Template
#--------------------------------------------------------------
data "template_file" "container_server_user_data" {
  template = "${file("provisioning/templates/container-server-cloud-config.tpl")}"

  vars {
    cluster_tag_key   = "${var.container_server_consul_tag_key}"
    cluster_tag_value = "${var.container_server_consul_tag_value}"
    cluster_nomad_num = "${var.cluster_nomad_num}"
  }
}

#--------------------------------------------------------------
# Container worker User Data Template
#--------------------------------------------------------------
data "template_file" "container_worker_user_data" {
  template = "${file("provisioning/templates/container-worker-cloud-config.tpl")}"
}
