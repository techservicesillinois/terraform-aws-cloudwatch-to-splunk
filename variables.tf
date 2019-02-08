##### Variables for aws_lambda_function resource.

# TODO: Function name is temporarily set via a variable in order to allow
#       multiple lambda functions to coexist until such time as we read
#       the Splunk HEC tokens from AWS Parameter Store, when we can 
#       coalesce into a single function shared among many applications.
variable "function_name" {
  description = "Name of the lambda function to be deployed (TEMPORARY)"
  default     = "cloudwatch_to_splunk"
}

variable "splunk_cache_ttl" {
  description = "Time-to-live value for cached Splunk connection"

  # Javascript maintains millisecond-resolution dates; the default value
  # is therefore 6 minutes.
  default = "6000"
}

variable "ssm_prefix" {
  description = "Prefix string to be applied to look up runtime SSM variables)"
  default     = "/cloudwatch_to_splunk"
}
