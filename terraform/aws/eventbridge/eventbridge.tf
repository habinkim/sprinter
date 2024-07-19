# EventBridge Rule
resource "aws_cloudwatch_event_rule" "media_convert_progressing_rule" {
  name        = "MediaConvertProgressingRule"
  description = "Triggered when MediaConvert job is progressing"
  event_pattern = jsonencode({
    "source" : ["aws.mediaconvert"],
    "detail-type" : ["MediaConvert Job State Change"],
    "detail" : {
      "status" : ["PROGRESSING"]
    }
  })
}

resource "aws_cloudwatch_event_rule" "media_convert_complete_rule" {
  name        = "MediaConvertCompleteRule"
  description = "Triggered when MediaConvert job is complete"
  event_pattern = jsonencode({
    "source" : ["aws.mediaconvert"],
    "detail-type" : ["MediaConvert Job State Change"],
    "detail" : {
      "status" : ["COMPLETE"]
    }
  })
}

resource "aws_cloudwatch_event_rule" "media_convert_canceled_rule" {
  name        = "MediaConvertCanceledRule"
  description = "Triggered when MediaConvert job is canceled"
  event_pattern = jsonencode({
    "source" : ["aws.mediaconvert"],
    "detail-type" : ["MediaConvert Job State Change"],
    "detail" : {
      "status" : ["CANCELED"]
    }
  })
}

resource "aws_cloudwatch_event_rule" "media_convert_error_rule" {
  name        = "MediaConvertErrorRule"
  description = "Triggered when MediaConvert job has an error"
  event_pattern = jsonencode({
    "source" : ["aws.mediaconvert"],
    "detail-type" : ["MediaConvert Job State Change"],
    "detail" : {
      "status" : ["ERROR"]
    }
  })
}

resource "aws_cloudwatch_event_target" "media_convert_complete_target" {
  target_id = "MediaConvertComplete"
  rule = aws_cloudwatch_event_rule.media_convert_complete_rule.name
  arn  = aws_sns_topic.media_convert_complete.arn

}