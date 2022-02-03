resource "aws_cloudwatch_log_group" "default" {
  name = "/aws/lambda/${var.function_name}"
}

locals {
  lambda_zip = "lambda/splunk-cloudwatch-logs-processor.zip"
}

resource "aws_lambda_function" "default" {
  description = "Stream events from AWS CloudWatch to Splunk event collector"

  # The function_name, runtime, memory_size, and timeout use variables
  # to facilitate testing of both new runtimes and new function versions.
  # End users will ordinarily use the default values.
  function_name = var.function_name

  runtime          = var.runtime
  memory_size      = var.memory_size
  timeout          = var.timeout
  handler          = "index.handler"
  publish          = true
  role             = aws_iam_role.default.arn
  filename         = local.lambda_zip
  source_code_hash = filebase64sha256(local.lambda_zip)
  tags             = var.tags

  environment {
    variables = {
      SPLUNK_CACHE_TTL = var.splunk_cache_ttl
      SSM_PREFIX       = var.ssm_prefix
    }
  }
}
