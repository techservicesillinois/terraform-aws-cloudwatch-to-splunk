##### Variables for aws_lambda_function resource.

# The function_name, runtime, memory_size, and timeout use variables
# to facilitate testing of both new runtimes and new function versions.
# End users will ordinarily use the default values.

variable "function_name" {
  description = "Name of the lambda function and role to be deployed"
  default     = "cloudwatch-to-splunk"
}

variable "memory_size" {
  description = "Amount of memory in MB for lambda function"
  default     = 512
}

variable "runtime" {
  description = "Lambda function's runtime environment"
}

variable "timeout" {
  description = "Time limit in seconds for lambda function"
  default     = 10
}

variable "splunk_cache_ttl" {
  description = "Time-to-live value for cached Splunk connection in milliseconds"

  # Set default cache TTL.
  default = 6 * 60 * 1000 # 6 minutes expressed in milliseconds.
}

variable "ssm_prefix" {
  description = "Prefix string to be applied to look up runtime SSM variables"
  default     = "/cloudwatch_to_splunk"
}

variable "tags" {
  description = "A mapping of tags to be supplied to resources where supported"
  type        = map(string)
  default     = {}
}
