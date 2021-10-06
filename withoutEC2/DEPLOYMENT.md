# DEPLOYMENT STEPS FOR TIMELOGGER

# FOR CLOUDFORMATION

Step 1:
    - Go to AWS console -> create an IAM user of type Programtic Access with administration access policy.
    - We will get ACCESS_KEY_ID and SECRET_ACCESS_KEY for created user.
Step 2:
    - Install aws cli on the local machine
            - FOR LINUX COMMANDS (https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html)

                - curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                - unzip awscliv2.zip
                - sudo ./aws/install
                - aws --version

            - FOR MAC  (https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html)

            - FOR WINDOWS  (https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)
                - Download executable from "https://awscli.amazonaws.com/AWSCLIV2.msi" and install it.
                - for checking installation, run command "aws --version"
Step 3:
    - Now confiure the installed aws cli on local machine
    - run command "aws configure" on shell and provide the IAM user credentials such as ACCESS_KEY_ID and SECRET_ACCESS_KEY and aws region
    - "region" must be where the timelogger needs to be deployed.. such as for Mumbai, region is "ap-south-1"

Step 4:
    - Now we need to run the cloudformation command to create AWS services such as "AWS Cognito" and "AWS S3" needed for timelogger.
    - Run command "aws cloudformation create-stack --stack-name tl-client-cloud --template-body file://./cloudformation.yml --capabilities CAPABILITY_NAMED_IAM" 

# FOR Docker Compose

Step 5:
    - The we need update the "docker-compose.yml" file and add the required credentials which are
        1. AWS_ACCESS_KEY_ID  - (This value is from STEP 1)
        2. AWS_SECRET_ACCESS_KEY  - (This value is from STEP 1)
        5. AWS_REGION  - (This value is from STEP 3 )
        3. COGNITO_USER_POOL_ID 
        4. COGNITO_CLIENT_ID
        6. S3_BUCKET
    - For 3,4 and 6 values go to aws console from browser and seach for clodformation and click on "tl-client-cloud" stack entry from the list.
    - Then go to outputs tab and there you will get the values such as 
            "S3BucketPath" for S3_BUCKET, "CognitoUserPoolID" for COGNITO_CLIENT_ID and "CognitoUserPoolClientID" for COGNITO_USER_POOL_ID

Step 6:
    - After editing the docker compose file copy that file to your EC2 instance 
    - Then run command to deploy all the services on ec2 
    - command "sudo docker-compose up -d"


# INSTRUCTIONS FOR EC2

- Install docker and docker compose on EC2 instance
- To install docker - commands :-("https://docs.docker.com/engine/install/ubuntu")
        1 - sudo apt-get update
        2 - sudo apt-get install \ apt-transport-https \ ca-certificates \ curl \ gnupg \ lsb-release
        3 -  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

        4 - echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

        5 - sudo apt-get update
        6 - sudo apt-get install docker-ce docker-ce-cli containerd.io
- To install docker compose - commands :-("https://docs.docker.com/compose/install/")
        1 -  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

        2 - sudo chmod +x /usr/local/bin/docker-compose

- We need to allow incoming traffic to our EC2 instance on ports 3000 and 8080.
- To allow these ports go the "security group" of the EC2 instance and click on "Inbound Rules" and click "Edit inbaound rules"
- Then "add rule" "Custom IP" and add "3000" in port range inside source select "0.0.0.0/0" CIDR block.
- again "add rule" "Custom IP" and add "8080" in port range inside source select "0.0.0.0/0" CIDR block. and click on "Save rules"
