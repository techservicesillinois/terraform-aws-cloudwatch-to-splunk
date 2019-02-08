locals {
  account_id = "${data.aws_caller_identity.current.account_id}"
  region     = "${data.aws_region.current.name}"
}

resource "aws_lambda_function" "default" {
  description = "Stream events from AWS CloudWatch to Splunk event collector"

  # TODO: Function name is temporarily set via a variable in order to allow
  #       multiple lambda functions to coexist until such time as we read
  #       the Splunk HEC tokens from AWS Parameter Store, when we can 
  #       coalesce into a single function shared among many applications.
  # function_name = "cloudwatch_to_splunk"
  function_name = "${var.function_name}"

  handler     = "index.handler"
  publish     = "true"
  role        = "${aws_iam_role.default.arn}"
  runtime     = "nodejs6.10"
  memory_size = "512"
  timeout     = "10"
  s3_bucket   = "drone-${local.region}-${local.account_id}"
  s3_key      = "splunk-aws-serverless-apps/splunk-cloudwatch-logs-processor.zip"

  environment {
    variables = {
      SPLUNK_CACHE_TTL = "${var.splunk_cache_ttl}"
      SSM_PREFIX       = "${var.ssm_prefix}"
    }
  }
}
