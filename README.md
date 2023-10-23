# cloudwatch-to-splunk

[![Terraform actions status](https://github.com/techservicesillinois/terraform-aws-cloudwatch-to-splunk/workflows/terraform/badge.svg)](https://github.com/techservicesillinois/terraform-aws-cloudwatch-to-splunk/actions)

Provides a lambda function that can be used with an arbitrary number of CloudWatch log groups to forward logs to [Splunk](https://www.splunk.com/). Each log group requires
a log filter and configuration using [AWS Systems Manager
Parameter
Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html)
(SSM). See the [documentation for splunk-aws-serverless-apps](https://github.com/techservicesillinois/splunk-aws-serverless-apps/) for more details.

Example Usage
-----------------

```hcl
module "foo" {
  source = "git@github.com:techservicesillinois/terraform-aws-cloudwatch-to-splunk//"
  # NOTE: Normally, callers will NOT specify the function name, except when
  # deploying a test version of the lambda code.
  # name = cloudwatch-to-splunk
}
```

Argument Reference
-----------------

The following arguments are supported:

* `name` - Name of the lambda function and role to be deployed
(default: *cloudwatch-to-splunk*). **NOTE:** In general, this should not
be overridden by end users.

* `memory_size` - Amount of memory in MB for lambda function
(default: 512).  **NOTE:** In general, this should not be overridden by
end users.

* `retention` - Log retention period in days (default: 30 days).

* `runtime` - Lambda function's runtime environment.
**NOTE:** This *_must_* be a `nodejs` environment supported by Amazon.
See the [AWS documentation on Lambda runtime environments](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html).

* `splunk_cache_ttl` - Time-to-live value for cached Splunk connection
in milliseconds (default: 360000 seconds, which is equal to 6 minutes).

* `ssm_prefix` - Prefix string to be applied to look up runtime SSM
variables (default: *cloudwatch\_to\_splunk*).

Attributes Reference
--------------------

The following attributes are exported:

* `qualified_arn` - The Amazon Resource Name (ARN) identifying your
Lambda function version.
