module "intranet" {
  source              = "./terraform-modules"
  region              = "ap-southeast-1"
  stageOneBucket      = "dsk-a1-bucket-s3"
  stageTwoBucket      = "dsk-b1-bucket-s3"
  stageThreeBucket    = "dsk-abc1-bucket-s3"
  successBucket       = "dsk-d1-bucket-s3-final-success"
  failureBucket       = "dsk-d2-bucket-s3-final-failure"
  stageOneSns         = "sk-a3-sns.fifo"
  stageTwoSns         = "sk-b3-sns.fifo"
  stageThreeSns       = "sk-c3-sns.fifo"
  apigateway          = "sk-api"
  stageOneSqs         = "sk-a4-sqs.fifo"
  stageTwoSqs         = "sk-b4-sqs.fifo"
  stageThreeSqs       = "sk-c4-sqs.fifo"
  stageOneLambdaOne   = "sk-a2-lambda"
  stageOneLambdaTwo   = "sk-a5-lambda"
  stageTwoLambdaOne   = "sk-b2-lambda"
  stageTwoLambdaTwo   = "sk-b5-lambda"
  stageThreeLambdaOne = "sk-c2-lambda"
  stageThreeLambdaTwo = "sk-c6-lambda"
  infraZone           = "intranet"
  lambdaTimeout       = 30
  sqsAlertQueue       = "alert"
  vpc_endpoint_ids    = ["vpce-09deef99b4857eceb"]
  security_group_ids  = ["sg-0a9b472e30d04eae9"]
  lambda_subnet_ids   = ["subnet-08d001784f7e4bbfc", "subnet-0202799018892b2eb"]
  default_tags = {
    Environment = "Test"
    Owner       = "TFProviders"
    Project     = "Test"
  }
}