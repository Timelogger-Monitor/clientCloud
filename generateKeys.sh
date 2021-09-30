#!/bin/sh
# This is a comment!
echo "Deleting old key if exists"
sleep 2
aws ec2 delete-key-pair --key-name time-logger

echo "generating key pair and saving to Ec2"
sleep 2
aws ec2 create-key-pair --key-name time-logger > privateKeyDetails.json
echo "key pair generated successfuly!"

sleep 2
echo "running cloudformation .. !"
aws cloudformation create-stack --stack-name tl-client-cloud --template-body file://./cloudformation.yml --capabilities CAPABILITY_NAMED_IAM
