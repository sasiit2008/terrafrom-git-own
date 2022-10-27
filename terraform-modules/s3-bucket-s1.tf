data "aws_s3_bucket" "a1" {
  bucket = var.stageOneBucket
}

resource "aws_lambda_permission" "a1" {
  statement_id  = "S3AllowInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.a2.arn
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.a1.arn
}

resource "aws_s3_bucket_notification" "a1" {
  bucket = data.aws_s3_bucket.a1.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.a2.arn
    events              = ["s3:ObjectCreated:*"]
    id                  = "${var.stageOneLambdaOne}-lambda-notification"
  }
}