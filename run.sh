#!/bin/bash

# Define variables
IMAGE_NAME="my-node-api"
CONTAINER_NAME="my-node-api-container"
NETWORK_NAME="my-network"
DOCKERFILE_PATH="."
PORT=3000

# Function to print error messages and exit
error_exit() {
    echo "$1" >&2
    exit 1
}

# Step 1: Build the Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME $DOCKERFILE_PATH || error_exit "Error: Failed to build Docker image."

# Step 2: Stop and remove any existing container with the same name (Optional)
echo "Stopping and removing existing container if any..."
docker ps -a -q -f name=$CONTAINER_NAME | grep -q . && docker rm -f $CONTAINER_NAME || echo "No existing container found."

# Step 3: Run a new container from the image
echo "Running Docker container..."
docker run -d --network $NETWORK_NAME -p $PORT:$PORT --name $CONTAINER_NAME $IMAGE_NAME || error_exit "Error: Failed to start Docker container."

# Step 4: Confirm the container is running
echo "Container is running. To view logs, use the following command:"
echo "docker logs $CONTAINER_NAME"

# Optional: Show the status of the container
docker ps | grep $CONTAINER_NAME || echo "Error: Container is not running."

echo "Script completed successfully."
