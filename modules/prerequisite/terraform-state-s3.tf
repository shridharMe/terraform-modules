resource "aws_s3_bucket" "terraform" {
  bucket = "${var.s3_bucket_name}"
  region = "${var.s3_region}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${aws_kms_key.kms-key.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags {
    Name        = "${var.s3_bucket_name}"
    Environment = "${var.env}"
  }

  versioning {
    enabled = true
  }
}

# grant terraform devloper /jenkins access to the bucket
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = "${aws_s3_bucket.terraform.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${var.terraform_user_arn}"
      },
      "Action": [ "s3:*" ],
      "Resource": [
        "${aws_s3_bucket.terraform.arn}",
        "${aws_s3_bucket.terraform.arn}/*"
      ]
    }
  ]
}
EOF
}
