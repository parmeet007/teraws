#Test
resource "aws_api_gateway_resource" "test_api" {
  parent_id   = aws_api_gateway_rest_api.test_api.root_resource_id
  path_part   = "test"
  rest_api_id = aws_api_gateway_rest_api.test_api.id
}

#resource "aws_api_gateway_method" "test_api" {
#  authorization = "NONE"
#  http_method   = "GET"
#  resource_id   = aws_api_gateway_resource.test_api.id
#  rest_api_id   = aws_api_gateway_rest_api.test_api.id
#}
#
#resource "aws_api_gateway_integration" "test_api" {
#  http_method = aws_api_gateway_method.test_api.http_method
#  resource_id = aws_api_gateway_resource.test_api.id
#  rest_api_id = aws_api_gateway_rest_api.test_api.id
#
#  integration_http_method = "POST"
#  type                    = "AWS_PROXY"
#  uri                     = aws_lambda_function.test_lambda.invoke_arn
#}


#resource "aws_lambda_permission" "apigw_lambda_test" {
#  statement_id  = "AllowExecutionFromAPIGatewayTEST"
#  action        = "lambda:InvokeFunction"
#  function_name = aws_lambda_function.test_lambda.function_name
#  principal     = "apigateway.amazonaws.com"
#
#  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.test_api.id}/*/${aws_api_gateway_method.test_api.http_method}${aws_api_gateway_resource.test_api.path}"
#}

# Test/West
resource "aws_api_gateway_resource" "west" {
  parent_id   = aws_api_gateway_rest_api.test_api.root_resource_id
  path_part   = "west"
  rest_api_id = aws_api_gateway_rest_api.test_api.id
}
resource "aws_api_gateway_method" "west" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.west.id
  rest_api_id   = aws_api_gateway_rest_api.test_api.id
}
resource "aws_api_gateway_integration" "west" {
  http_method = aws_api_gateway_method.west.http_method
  resource_id = aws_api_gateway_resource.west.id
  rest_api_id = aws_api_gateway_rest_api.test_api.id

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.test_lambda.invoke_arn
}


resource "aws_lambda_permission" "apigw_lambda_west" {
  statement_id  = "AllowExecutionFromAPIGatewayWEST"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.test_api.id}/*/${aws_api_gateway_method.west.http_method}${aws_api_gateway_resource.west.path}"
}

#Proxy
resource "aws_api_gateway_resource" "test_proxy" {
  parent_id   = aws_api_gateway_resource.test_api.id
  path_part   = "{proxy+}"
  rest_api_id = aws_api_gateway_rest_api.test_api.id
}
resource "aws_api_gateway_method" "test_proxy" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.test_proxy.id
  rest_api_id   = aws_api_gateway_rest_api.test_api.id
}
resource "aws_api_gateway_integration" "test_proxy" {
  http_method = aws_api_gateway_method.test_proxy.http_method
  resource_id = aws_api_gateway_resource.test_proxy.id
  rest_api_id = aws_api_gateway_rest_api.test_api.id

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.test_lambda.invoke_arn
}


resource "aws_lambda_permission" "apigw_lambda_test_proxy" {
  statement_id  = "AllowExecutionFromAPIGatewayProxy"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.test_api.id}/*/${aws_api_gateway_method.test_proxy.http_method}${aws_api_gateway_resource.test_proxy.path}"
}
