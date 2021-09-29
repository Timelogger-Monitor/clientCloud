# To create a new stack
aws cloudformation create-stack --stack-name tl-client-cloud --template-body file://./cloudformation.yml --capabilities CAPABILITY_NAMED_IAM


# Create Keys

aws ec2 create-key-pair --key-name MyKeyPair -- key-type rsa