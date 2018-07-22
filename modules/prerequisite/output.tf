output "kms-key" {
  value = "${aws_kms_key.kms-key.arn}"
}

output "terraform-state-s3" {
  value = "${aws_s3_bucket.terraform.arn}"
}
output "terraform-lock-db" {
  value = "${aws_dynamodb_table.terraform.arn}"
}