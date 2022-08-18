resource "aws_api_gateway_rest_api" "MyDemoAPI" {
  name        = "my-sqs-api"
  description = "POST records to SQS queue"
}

resource "aws_api_gateway_resource" "MyDemoResource" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  parent_id   = aws_api_gateway_rest_api.MyDemoAPI.root_resource_id
  path_part   = "mydemoresource"
}

resource "aws_api_gateway_method" "MyDemoMethod" {
  rest_api_id      = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id      = aws_api_gateway_resource.MyDemoResource.id
  api_key_required = false
  http_method      = "POST"
  authorization    = "NONE"
  request_models = {
    "application/json" = aws_api_gateway_model.demo-method.name
  }
  request_parameters = {
    "method.request.path.proxy"        = false
    "method.request.querystring.unity" = false
  }
  request_validator_id = aws_api_gateway_request_validator.demo-validator.id
}


resource "aws_api_gateway_integration" "MyDemoIntegration" {
  rest_api_id             = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id             = aws_api_gateway_resource.MyDemoResource.id
  http_method             = aws_api_gateway_method.MyDemoMethod.http_method
  type                    = "AWS"
  integration_http_method = "POST"

  passthrough_behavior = "NEVER"
  credentials          = aws_iam_role.APIGWRole.arn
  uri                  = "arn:aws:apigateway:${var.region}:sqs:path/${aws_sqs_queue.MySQSqueue.name}"

  request_parameters = {
    "integration.request.header.Content-Type" = "'application/x-www-form-urlencoded'"
  }

  request_templates = {
    "application/json" = "Action=SendMessage&MessageBody=$input.body"
  }

}

resource "aws_api_gateway_deployment" "demo-deploy" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  stage_name  = "main"

}


resource "aws_api_gateway_request_validator" "demo-validator" {
  rest_api_id                 = aws_api_gateway_rest_api.MyDemoAPI.id
  name                        = "payload-validator"
  validate_request_body       = false
  validate_request_parameters = false

}

resource "aws_api_gateway_model" "demo-method" {
  rest_api_id  = aws_api_gateway_rest_api.MyDemoAPI.id
  name         = "PayloadValidator"
  description  = "validate the json body content conforms to the below spec"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "required": [ "id", "docs"],
  "properties": {
    "id": { "type": "string" },
    "docs": {
      "minItems": 1,
      "type": "array",
      "items": {
        "type": "object"
      }
    }
  }
}
EOF
}