locals {
  account_id = "${data.aws_caller_identity.current.account_id}"
  region     = "${data.aws_region.current.name}"
}

resource "aws_cloudwatch_log_group" "default" {
  name = "/aws/lambda/${var.function_name}"
}

resource "aws_lambda_function" "default" {
  description = "Stream events from AWS CloudWatch to Splunk event collector"

  # The function_name, runtime, memory_size, and timeout use variables
  # to facilitate testing of both new runtimes and new function versions.
  # End users will ordinarily use the default values.
  function_name = "${var.function_name}"

  runtime     = "${var.runtime}"
  memory_size = "${var.memory_size}"
  timeout     = "${var.timeout}"
  handler     = "index.handler"
  publish     = "true"
  role        = "${aws_iam_role.default.arn}"
  s3_bucket   = "drone-${local.region}-${local.account_id}"
  s3_key      = "splunk-aws-serverless-apps/splunk-cloudwatch-logs-processor.zip"

  environment {
    variables = {
      SPLUNK_CACHE_TTL = "${var.splunk_cache_ttl}"
      SSM_PREFIX       = "${var.ssm_prefix}"
    }
  }
}
