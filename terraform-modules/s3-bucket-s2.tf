data "aws_s3_bucket" "b1" {
  bucket = var.stageTwoBucket
}

resource "aws_lambda_permission" "b1" {
  statement_id  = "S3AllowInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.b2.arn
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.b1.arn
}

resource "aws_s3_bucket_notification" "b1" {
  bucket = data.aws_s3_bucket.b1.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.b2.arn
    events              = ["s3:ObjectTagging:*"]
    id                  = "${var.stageTwoLambdaOne}-lambda-notification"
  }
}


