#!/bin/bash

# Set environment variables
AWS_DEFAULT_REGION='ap-southeast-1'
ECR_REPOSITORY_URI='105529915521.dkr.ecr.ap-southeast-1.amazonaws.com/my-web-app'
BUILD_TAG='tag'
GITHUB_REPO_URL='https://github.com/nguyenquockhang1610/web.git'

# Stage 1: AWS ECR - Login
echo "AWS ECR - Login"
aws ecr get-login-password --region "${AWS_DEFAULT_REGION}" | docker login --username AWS --password-stdin 105529915521.dkr.ecr.ap-southeast-1.amazonaws.com

# Stage 2: Clone GitHub Repo
sudo rm -rf web
echo "Clone GitHub Repo"
sudo git clone "${GITHUB_REPO_URL}" .

# Stage 3: Build and Push Docker Image
echo "Build and Push Docker Image"
ecrImage="${ECR_REPOSITORY_URI}:${BUILD_TAG}"
imageId=$(docker build -q -t "${ecrImage}" . | tr -d '\n')
docker tag "${imageId}" "${ecrImage}"
docker push "${ecrImage}"

# Stage 4: Terraform Apply
echo "Terraform Apply"
if [ "${BUILD_RESULT}" == "SUCCESS" ]; then
    terraform apply -auto-approve
fi

# Stage 5: Push code to GitHub
git remote add github_repo1 https://github.com/nguyenquockhang1610/terraform-kubernetes.git
git add .
git commit -m "Update from Jenkins"
git push github_repo1 master