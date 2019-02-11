# Normally, callers will use the default for ${var.function_name}, but
# overriding may be useful for testing.
variable "function_name" {
  description = "Name of the lambda function and role to be deployed"
  default     = "cloudwatch_to_splunk"
}

variable "splunk_cache_ttl" {
  description = "Time-to-live value for cached Splunk connection in milliseconds"
  default = "6000"    # 6 minutes.
}

variable "ssm_prefix" {
  description = "Prefix string to be applied to look up runtime SSM variables)"
  default     = "/cloudwatch_to_splunk"
}
