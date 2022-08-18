/*resource "aws_apigatewayv2_api" "MYAPIgateway" {
  name          = "demo-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "demo-stage" {
  api_id = aws_apigatewayv2_api.MYAPIgateway.id
  name   = "Demo-stage"
}

/*resource "aws_apigatewayv2_route" "demo-route" {
  api_id    = aws_apigatewayv2_api.MYAPIgateway.id
  route_key = "$default"
}*/

/*resource "aws_apigatewayv2_deployment" "demo-deploy" {
  api_id      = aws_apigatewayv2_api.MYAPIgateway.id
  description = "demo deployment"

  lifecycle {
    create_before_destroy = true
  }
}*/

