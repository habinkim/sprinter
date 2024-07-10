# SNS
resource "aws_sns_topic" "media_convert_complete_topic" {
  name = "MediaConvertComplete"
}

resource "aws_sns_topic_policy" "media_convert_complete_topic_policy" {
  arn    = aws_sns_topic.media_convert_complete_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission"
    ]

    resources = [
      aws_sns_topic.media_convert_complete_topic.arn
    ]
  }
}

resource "aws_sns_topic_subscription" "media_convert_complete_topic_subscription" {
  topic_arn = aws_sns_topic.media_convert_complete_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.persist_transcoding_history.arn
}