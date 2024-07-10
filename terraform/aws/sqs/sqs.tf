# SQS
resource "aws_sqs_queue" "register_transcoding_job" {
  name             = "register-transcoding-job-queue"
  max_message_size = 2048
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.register_transcoding_job_dlq.arn
    maxReceiveCount     = 5
  })
}

resource "aws_sqs_queue" "register_transcoding_job_dlq" {
  name = "register-transcoding-job-dlq"
}

resource "aws_sqs_queue" "persist_transcoding_history" {
  name = "persist-transcoding-history-queue"
  max_message_size = 2048
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.persist_transcoding_history_dlq.arn
    maxReceiveCount     = 5
  })
}

resource "aws_sqs_queue" "persist_transcoding_history_dlq" {
    name = "persist-transcoding-history-dlq"
}