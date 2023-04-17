#!/bin/bash

# Pass arguments
BASE_IMAGE="$1"
AWS_ACCOUNT_ID="$2"
AWS_REGION="$3"
# Set the name and tag for the ECR repository and image
ECR_REPOSITORY="sagemaker-text-generation-inference"
ECR_IMAGE_TAG="latest"

# Log in to ECR
echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

# Create the ECR repository if it doesn't already exist
echo "Creating ECR repository $ECR_REPOSITORY..."
aws ecr describe-repositories --repository-names "$ECR_REPOSITORY" || aws ecr create-repository --repository-name "$ECR_REPOSITORY"

# Pull the Docker Hub image
echo "Pulling base image $BASE_IMAGE..."
docker pull $BASE_IMAGE

# Tag the Docker Hub image with the ECR repository and image tag
echo "Tagging image $BASE_IMAGE as $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$ECR_IMAGE_TAG..."
docker tag "$BASE_IMAGE" "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$ECR_IMAGE_TAG"

# Push the Docker image to ECR
echo "Pushing image to ECR..."
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$ECR_IMAGE_TAG"

# Clean up local images
echo "Cleaning up local images..."
docker rmi "$BASE_IMAGE"
docker rmi "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$ECR_IMAGE_TAG"