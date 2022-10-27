data "aws_iam_policy_document" "b3" {
  policy_id = "__default_policy__"
  statement {
    actions = [
      "SNS:Publish",
      "SNS:RemovePermission",
      "SNS:SetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:AddPermission",
      "SNS:Subscribe"
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"
      values = [
        data.aws_caller_identity.account.account_id
      ]
    }
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = [aws_sns_topic.b3.arn]
    sid       = "__sub_and_pub__"
  }
}

resource "aws_sns_topic" "b3" {
  name                        = var.stageTwoSns
  fifo_topic                  = true
  content_based_deduplication = true
}

resource "aws_sns_topic_policy" "b3" {
  arn    = aws_sns_topic.b3.arn
  policy = data.aws_iam_policy_document.b3.json
}

resource "aws_sns_topic_subscription" "b3" {
  topic_arn            = aws_sns_topic.b3.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.b4.arn
  raw_message_delivery = true
}
