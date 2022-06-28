resource "aws_api_gateway_deployment" "test_api" {
  rest_api_id = aws_api_gateway_rest_api.test_api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.test_api.body,

      aws_api_gateway_resource.test_api.id,
#      aws_api_gateway_method.test_api.id,
#      aws_api_gateway_integration.test_api.id,

      aws_api_gateway_resource.west.id,
      aws_api_gateway_method.west.id,
      aws_api_gateway_integration.west.id,

      aws_api_gateway_resource.test_proxy.id,
      aws_api_gateway_method.test_proxy.id,
      aws_api_gateway_integration.test_proxy.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "test_api" {
  deployment_id = aws_api_gateway_deployment.test_api.id
  rest_api_id   = aws_api_gateway_rest_api.test_api.id
  stage_name    = "v1"
}