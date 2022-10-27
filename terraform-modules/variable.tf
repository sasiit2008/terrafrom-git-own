variable "region" {}
variable "stageOneBucket" {}
variable "stageTwoBucket" {}
variable "stageThreeBucket" {}
variable "successBucket" {}
variable "failureBucket" {}
variable "apigateway" {}
variable "stageOneSns" {}
variable "stageTwoSns" {}
variable "stageThreeSns" {}
variable "stageOneSqs" {}
variable "stageTwoSqs" {}
variable "stageThreeSqs" {}
variable "stageOneLambdaOne" {}
variable "stageOneLambdaTwo" {}
variable "stageTwoLambdaOne" {}
variable "stageTwoLambdaTwo" {}
variable "stageThreeLambdaOne" {}
variable "stageThreeLambdaTwo" {}
variable "infraZone" {}
variable "lambdaTimeout" {}
variable "sqsAlertQueue" {}
variable "vpc_endpoint_ids" {}
variable "lambda_subnet_ids" {}
variable "security_group_ids" {}
variable "default_tags" {
  description = "Default Tags for resources created by terraform"
  type        = map(string)
}

