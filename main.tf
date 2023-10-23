resource "aws_cloudwatch_log_group" "default" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.retention
  tags              = local.tags
}

locals {
  lambda_zip = "lambda/splunk-cloudwatch-logs-processor.zip"
  tags       = merge({ Name = var.function_name }, var.tags)
}

resource "aws_lambda_function" "default" {
  description   = "Stream events from AWS CloudWatch to Splunk event collector"
  function_name = var.function_name

  # The runtime, memory_size, and timeout are defined as examples to
  # facilitate testing and deployment new function versions and upgrades
  # to runtime versions. End users will ordinarily use the default values.

  runtime          = var.runtime
  memory_size      = var.memory_size
  timeout          = var.timeout
  handler          = "index.handler"
  publish          = true
  role             = aws_iam_role.default.arn
  filename         = local.lambda_zip
  source_code_hash = filebase64sha256(local.lambda_zip)
  tags             = local.tags

  environment {
    variables = {
      SPLUNK_CACHE_TTL = var.splunk_cache_ttl
      SSM_PREFIX       = var.ssm_prefix
    }
  }
}
