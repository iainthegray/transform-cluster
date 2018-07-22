job "transform" {
  type        = "batch"
  datacenters = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

  meta {
    input   = ""
  }

  parameterized {
    meta_required = ["input"]
  }

  task "tf" {
    driver = "exec"

    config {
      command = "/usr/local/bin/letter_sub.sh"
      args    = ["${NOMAD_META_INPUT}"]
    }

    resources {
      cpu    = 1000
      memory = 256
    }
  }
}
