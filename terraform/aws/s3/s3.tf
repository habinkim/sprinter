# S3 Buckets
resource "aws_s3_bucket" "transcoding_input" {
  bucket = "transcoding-input-bucket"
}

resource "aws_s3_bucket_lifecycle_configuration" "transcoding_input_bucket_lifecycle" {
  bucket = aws_s3_bucket.transcoding_input.id

  rule {
    id      = "transcoding_input_bucket_lifecycle_rule"
    enabled = true
    tags = {
      Name = "transcoding_input_bucket_lifecycle_rule"
    }

    expiration {
      days = 90
    }

    transition {
      days          = 30
      storage_class = "GLACIER"
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_notification" "transcoding_input_bucket_notification" {
  bucket = aws_s3_bucket.transcoding_input.id

  queue {
    queue_arn = aws_sqs_queue.register_transcoding_job.arn
    events    = ["s3:ObjectCreated:*"]
    filter_prefix = "input/"
    filter_suffix = ".mov"
  }
}

resource "aws_s3_bucket" "transcoding_output" {
  bucket = "transcoding-output-bucket"
}