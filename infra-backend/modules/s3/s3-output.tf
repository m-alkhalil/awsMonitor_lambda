output "s3-locking-id" {
    description = "s3 locking bucket Id"
  value = aws_s3_bucket.s3-state-locking-bucket.id
}