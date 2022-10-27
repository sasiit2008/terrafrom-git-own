module "intranet" {
  source              = "./terraform-modules"
  region              = "ap-southeast-1"
  stageOneBucket      = "sst-s3-bukcet-dropexternal"
  stageTwoBucket      = "sst-s3-bukcet-scanning"
  stageThreeBucket    = "sst-s3-bukcet-safe"
  successBucket       = "sst-s3-bukcet-sucess"
  failureBucket       = "sst-s3-bukcet-failure"
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
    Environment = "Uat"
    Owner       = "TFProviders"
    Project     = "BCA"
  }
}
