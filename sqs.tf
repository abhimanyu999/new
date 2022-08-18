#Create SQS queue
resource "aws_sqs_queue" "MySQSqueue" {
  name = "api-sqs"
}