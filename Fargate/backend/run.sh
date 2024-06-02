#!/bin/bash

echo "Backend"

# Variables
ECR_REPOSITORY="975050228305.dkr.ecr.us-east-1.amazonaws.com/tictactoe-backend"
IP_ADDRESS="192.168.100.18" 

# Build Docker image
docker build -t tictactoe-backend --build-arg IP=$IP_ADDRESS .

# Log in to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REPOSITORY

# Tag the Docker image
docker tag tictactoe-backend:latest $ECR_REPOSITORY:latest

# Push the Docker image to ECR
docker push $ECR_REPOSITORY:latest

echo "Backend Docker image built and pushed to ECR successfully."