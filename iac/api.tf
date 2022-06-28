resource "aws_api_gateway_rest_api" "test_api" {
  body = jsonencode({
    openapi = "3.0.1"
    info    = {
      title   = "terra_api_title"
      version = "1.0"
    }
  })

  name = "terra_api_2"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
