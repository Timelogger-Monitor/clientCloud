#!/bin/sh
# This is a comment!
echo "Enter EC2 instance public IP"
sleep 2
read publicip
echo "publicIP ${publicip}"

chmod 777 privateKey.pem
echo "creating privateKey pem from JSON"
node createPem.js
sleep 3

echo "make privateKey pem read only"
chmod 400 privateKey.pem
sleep 3
echo "copying docker-compose to server"
scp -i privateKey.pem docker-compose.yml ubuntu@"${publicip}":/home/ubuntu/
sleep 3
echo "docker-compose copy done"
sleep 2
echo "running docker-compose on server"
ssh -i privateKey.pem ubuntu@"${publicip}" -f sudo docker-compose up --build -d

# 13.233.65.104