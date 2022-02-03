## Building the Node.js lambda function 
The lambda function is named `splunk-cloudwatch-logs-processor`, and is found in the repository

```
git@github.com:techservicesillinois/splunk-aws-serverless-apps
```

in the `splunk-cloudwatch-logs-processor` subdirectory.

In order to build, navigate to that directory, and run `make`. The build process will produce an artifact `splunk-cloudwatch-logs-processor.zip` in that directory. Copy that ZIP file into *this* repository – `terraform-aws-cloudwatch-to-splunk`, in the `lambda` subdirectory, and commit to Git. Don't forget to tag the new version.

Subsequent infrastructure builds against the module using `terraform apply` (or terragrunt equivalent) will deploy the lambda function in the account and region specified. Take care to specify a Node.js version supported by the AWS lambda runtime. See https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html.