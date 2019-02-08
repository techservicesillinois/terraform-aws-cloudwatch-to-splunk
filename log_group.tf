resource "aws_cloudwatch_log_group" "default" {
  name = "/aws/lambda/${var.function_name}"
}
