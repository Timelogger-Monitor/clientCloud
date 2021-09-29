# To create a new stack
aws cloudformation create-stack --stack-name testStack --template-body file://./cloudformation.yml --capabilities CAPABILITY_NAMED_IAM