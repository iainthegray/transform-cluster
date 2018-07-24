job "transform" {
  type        = "batch"
  datacenters = ["eu-west-1"]

  meta {
    input   = ""
  }

  parameterized {
    meta_required = ["s3_file"]
  }

  task "tf" {
    driver = "exec"

    config {
      command = "/usr/bin/python"
      args    = ["/usr/local/bin/pii_remove.py", "-i", "${NOMAD_META_S3_FILE}"]
    }

    resources {
      cpu    = 1000
      memory = 256
    }
  }
}
