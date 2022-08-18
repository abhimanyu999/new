# Create an IAM role for API Gateway
resource "aws_iam_role" "APIGWRole" {
  name = "APISQS"

  assume_role_policy = <<POLICY1
{
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "apigateway.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }
  ]
}
POLICY1
}

# Create an IAM policy for API Gateway For full access to SQS
resource "aws_iam_policy" "APIGWPolicy" {
  name   = "SQS_policy"
  policy = <<POLICY2
{
  "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "sqs:*"
            ],
            "Effect": "Allow",
            "Resource" : "${aws_sqs_queue.MySQSqueue.arn}"
       }
  ]
}
POLICY2
}

# Attach the IAM policies to the equivalent rule
resource "aws_iam_role_policy_attachment" "APIGWPolicyAttachment" {
  role       = aws_iam_role.APIGWRole.name
  policy_arn = aws_iam_policy.APIGWPolicy.arn
}
