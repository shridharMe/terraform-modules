resource "aws_kms_key" "kms-key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}
