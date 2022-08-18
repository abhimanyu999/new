/*resource "aws_apigatewayv2_integration" "sqs_hello" {
  api_id              = aws_apigatewayv2_api.MYAPIgateway.id
  credentials_arn     = aws_iam_role.APIGWRole.arn
  description         = "SQS example"
  integration_type    = "AWS_PROXY"
  integration_subtype = "SQS-SendMessage"
 
   request_parameters = {
    "QueueUrl"    = "$request.header.queueUrl"
    "MessageBody" = "$request.body.message"
  }
}

resource "aws_apigatewayv2_route" "get_hello" {
  api_id = aws_apigatewayv2_api.MYAPIgateway.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.sqs_hello.id}"
}

resource "aws_apigatewayv2_route" "put_hello" {
  api_id = aws_apigatewayv2_api.MYAPIgateway.id

  route_key = "PUT /hello"
  target    = "integrations/${aws_apigatewayv2_integration.sqs_hello.id}"
}*/
