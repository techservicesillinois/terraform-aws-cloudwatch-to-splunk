cd splunk-cloudwatch-logs-processor
git submodule init https://github.com/splunk/splunk-aws-serverless-apps/

cd splunk-cloudwatch-logs-processor
npm install
npm run build:zip
