output "backend_bucket_name" {
  value = aws_s3_bucket.tf_state.id
}

output "backend_lock_table" {
  value = aws_dynamodb_table.tf_lock.name
}
