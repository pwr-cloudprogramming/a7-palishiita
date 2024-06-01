#!/bin/bash -v
echo "userdata-start"
sudo apt update -y
sudo apt install -y docker.io
sudo apt install -y docker-compose
sudo systemctl start docker

sudo touch ~/.ssh/myrepokey
echo "-----BEGIN OPENSSH PRIVATE KEY-----" >> ~/.ssh/myrepokey
echo "b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW" >> ~/.ssh/myrepokey
echo "QyNTUxOQAAACC7J5HuWhtg9y0L9rk5OmSjRuR1XotisnIOB/zIbG+AYQAAAJgRK73YESu9" >> ~/.ssh/myrepokey
echo "2AAAAAtzc2gtZWQyNTUxOQAAACC7J5HuWhtg9y0L9rk5OmSjRuR1XotisnIOB/zIbG+AYQ" >> ~/.ssh/myrepokey
echo "AAAEDpbSDuBIYc7EDtSM0Xiyss0/gRu0TVkI4KuT4rpPnmsbsnke5aG2D3LQv2uTk6ZKNG" >> ~/.ssh/myrepokey
echo "5HVei2Kycg4H/Mhsb4BhAAAAFGlzaGlpdGFwYWxAZ21haWwuY29tAQ==" >> ~/.ssh/myrepokey
echo "-----END OPENSSH PRIVATE KEY-----" >> ~/.ssh/myrepokey

sudo touch ~/.ssh/myrepokey.pub
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILsnke5aG2D3LQv2uTk6ZKNG5HVei2Kycg4H/Mhsb4Bh ishiitapal@gmail.com" >> ~/.ssh/myrepokey.pub

sudo touch ~/.ssh/config
echo "Host github.com-app-repo" >> ~/.ssh/config
echo "Hostname github.com" >> ~/.ssh/config
echo "IdentityFile=~/.ssh/myrepokey" >> ~/.ssh/config

sudo chmod 600 ~/.ssh/myrepokey

ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

sudo git clone git@github.com-app-repo:pwr-cloudprogramming/a7-palishiita.git

sh /a7-palishiita/EBS/build/run.sh
sudo docker run --name backend -d -p 8080:8080 build_backend
sudo docker run --name frontend -d -p 80:80 build_frontend