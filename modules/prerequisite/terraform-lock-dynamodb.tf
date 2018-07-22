resource "aws_dynamodb_table" "terraform" {
  name           = "${var.dynamodb_table}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  server_side_encryption {
    enabled = true
  }
}