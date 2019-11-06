# cloudwatch-to-splunk

[![Build Status](https://drone.techservices.illinois.edu/api/badges/techservicesillinois/terraform-aws-cloudwatch-to-splunk/status.svg)](https://drone.techservices.illinois.edu/techservicesillinois/terraform-aws-cloudwatch-to-splunk)

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
  # function_name = cloudwatch-to-splunk
}
```

Argument Reference
-----------------

The following arguments are supported:

* `function_name` - Name of the lambda function and role to be deployed
(default: *cloudwatch-to-splunk*). **NOTE:** In general, this should not
be overridden by end users.

* `memory_size` - Amount of memory in MB for lambda function
(default: 512).  **NOTE:** In general, this should not be overridden by
end users.

* `runtime` - Lambda function's runtime environment (default: nodejs8.10).
**NOTE:** In general, this should not be overridden by end users.

* `splunk_cache_ttl` - Time-to-live value for cached Splunk connection
in milliseconds (default: *6000*)

* `ssm_prefix` - Prefix string to be applied to look up runtime SSM
variables (default: *cloudwatch_to_splunk*)

Attributes Reference
--------------------

The following attributes are exported:

* `qualified_arn` - The Amazon Resource Name (ARN) identifying your
Lambda function version.
