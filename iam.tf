# Splunk blue prints:
#   https://www.splunk.com/blog/2017/02/03/how-to-easily-stream-aws-cloudwatch-logs-to-splunk.html
#
# IAM Manual for CloudWatch:
#   https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatchlogs.html#amazoncloudwatchlogs-policy-keys

locals {
  # Remove leading slashes
  ssm_prefix = "${join("/", compact(split("/", var.ssm_prefix)))}"
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["${aws_cloudwatch_log_group.default.arn}"]
  }

  statement {
    actions = [
      "logs:PutLogEvents",
    ]

    resources = [
      "${aws_cloudwatch_log_group.default.arn}",
      "${aws_cloudwatch_log_group.default.arn}:*:*",
    ]
  }

  statement {
    actions = [
      "ssm:GetParameters",
    ]

    resources = ["${format("arn:aws:ssm:%s:%s:parameter/%s/*", data.aws_region.current.name, data.aws_caller_identity.current.account_id, local.ssm_prefix)}"]
  }
}

data "aws_iam_policy_document" "assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }

  # This statement is not required for production, but it's useful for debugging.
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["${format("arn:aws:iam::%s:root", data.aws_caller_identity.current.account_id)}"]
    }
  }
}

resource "aws_iam_policy" "default" {
  name        = "${var.function_name}"
  path        = "/"
  description = "Policy controlling access granted to lambda function ${var.function_name}"
  policy      = "${data.aws_iam_policy_document.default.json}"
}

resource "aws_iam_role" "default" {
  name               = "${var.function_name}"
  path               = "/"
  description        = "Role assumed by lambda function ${var.function_name}"
  assume_role_policy = "${data.aws_iam_policy_document.assume-role-policy.json}"
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = "${aws_iam_role.default.name}"
  policy_arn = "${aws_iam_policy.default.arn}"
}
