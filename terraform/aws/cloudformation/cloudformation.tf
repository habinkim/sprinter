provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_cloudformation_stack" "mediaconvert_stack" {
  name = "MediaConvertStack"

  template_body = jsonencode(
    {
      "AWSTemplateFormatVersion" : "2010-09-09",
      "Resources" : {
        "MediaConvertQueue" : {
          "Type" : "AWS::MediaConvert::Queue",
          "Properties" : {
            "Name" : "Sprinter TransCoding Queue",
            "Description" : "Default queue for MediaConvert jobs"
          }
        },
        "MediaConvertJobTemplate" : {
          "Type" : "AWS::MediaConvert::JobTemplate",
          "Properties" : {
            "Name" : "ShortForm Apple HLS HD Job",
            "Description" : "ShortForm Apple HLS HD Job Template",
            "SettingsJson" : {
              "OutputGroups" : [
                {
                  "Name" : "File Group",
                  "Outputs" : [
                    {
                      "ContainerSettings" : {
                        "Container" : "MP4"
                      },
                      "VideoDescription" : {
                        "CodecSettings" : {
                          "Codec" : "H_264",
                          "H264Settings" : {
                            "RateControlMode" : "VBR",
                            "MaxBitrate" : 5000000,
                            "QualityTuningLevel" : "SINGLE_PASS",
                            "FramerateControl" : "INITIALIZE_FROM_SOURCE"
                          }
                        }
                      },
                      "AudioDescriptions" : [
                        {
                          "CodecSettings" : {
                            "Codec" : "AAC",
                            "AacSettings" : {
                              "Bitrate" : 96000,
                              "CodingMode" : "CODING_MODE_2_0",
                              "SampleRate" : 48000
                            }
                          }
                        }
                      ]
                    }
                  ],
                  "OutputGroupSettings" : {
                    "Type" : "FILE_GROUP_SETTINGS",
                    "FileGroupSettings" : {
                      "Destination" : "s3://transcoding-output-bucket/"
                    }
                  }
                }
              ]
            }
          }
        }
      }
    }
  )
}

output "mediaconvert_queue_name" {
  value = aws_cloudformation_stack.mediaconvert_stack.outputs["MediaConvertQueue"]
}

output "mediaconvert_job_template_name" {
  value = aws_cloudformation_stack.mediaconvert_stack.outputs["MediaConvertJobTemplate"]
}
