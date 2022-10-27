data "aws_s3_bucket" "d1" {
  bucket = var.successBucket
}

data "aws_s3_bucket" "d2" {
  bucket = var.failureBucket
}

data "aws_sqs_queue" "alert" {
  name = var.sqsAlertQueue
}