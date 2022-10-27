module "intranet" {
  source              = "./terraform-modules"
  region              = "ap-southeast-1"
  stageOneBucket      = "sst-s3-bukcet-dropexternal"
  stageTwoBucket      = "sst-s3-bukcet-scanning"
  stageThreeBucket    = "sst-s3-bukcet-safe"
  successBucket       = "sst-s3-bukcet-sucess"
  failureBucket       = "sst-s3-bukcet-failure"
  stageOneSns         = "sst-a3-sns.fifo"
  stageTwoSns         = "sst-b3-sns.fifo"
  stageThreeSns       = "sst-c3-sns.fifo"
  apigateway          = "sst-api"
  stageOneSqs         = "sst-a4-sqs.fifo"
  stageTwoSqs         = "sst-b4-sqs.fifo"
  stageThreeSqs       = "sst-c4-sqs.fifo"
  stageOneLambdaOne   = "sst-a2-lambda"
  stageOneLambdaTwo   = "sst-a5-lambda"
  stageTwoLambdaOne   = "sst-b2-lambda"
  stageTwoLambdaTwo   = "sst-b5-lambda"
  stageThreeLambdaOne = "sst-c2-lambda"
  stageThreeLambdaTwo = "sst-c6-lambda"
  infraZone           = "intranet"
  lambdaTimeout       = 30
  sqsAlertQueue       = "fhq-uat-antivirus-cloud"
  vpc_endpoint_ids    = ["vpce-09deef99b4857eceb"]
  security_group_ids  = ["sg-0a9b472e30d04eae9"]
  lambda_subnet_ids   = ["subnet-08d001784f7e4bbfc", "subnet-0202799018892b2eb"]
  default_tags = {
    Environment = "Uat"
    Owner       = "TFProviders"
    Project     = "BCA"
  }
}
