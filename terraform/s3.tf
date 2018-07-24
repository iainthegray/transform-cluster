#--------------------------------------------------------------
# Container Server IAM Role and Policy
#--------------------------------------------------------------
resource "aws_s3_bucket" "transform-bucket-irg-test" {
  bucket = "${var.transform-bucket}"
  acl    = "public-read"

  tags {
    Name = "${var.transform-bucket}"
  }
}
