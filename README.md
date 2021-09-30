# To create a new stack
aws cloudformation create-stack --stack-name tl-client-cloud --template-body file://./cloudformation.yml --capabilities CAPABILITY_NAMED_IAM

# To delete the stack
aws cloudformation delete-stack --stack-name tl-client-cloud

# Create Keys

aws ec2 create-key-pair --key-name time-logger

# Delete Keys
aws ec2 delete-key-pair --key-name time-logger

