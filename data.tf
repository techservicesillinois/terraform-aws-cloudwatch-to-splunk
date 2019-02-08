# Use data sources to retrieve account number and region.

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
