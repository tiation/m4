#!/bin/bash

# Seamless Startup Script for Development Environment

# Open essential GUI applications
open -a "Warp"
open -a "Visual Studio Code"
open -a "Docker"
open -a "Android Studio"
open -a "Google Chrome"

# Start Docker Desktop and wait for it to be ready
echo "Starting Docker..."
open --background -a Docker

while ! docker system info > /dev/null 2>&1; do
  echo "Waiting for Docker to start..."
  sleep 2
done
echo "Docker is running."

# Activate Python AI development environment
source ~/ai-dev/bin/activate

echo "Python AI environment activated."

# Start Minikube Kubernetes cluster
minikube start

echo "Minikube Kubernetes cluster started."

# Open Warp Terminal with a new session
echo "Opening Warp Terminal..."
open -a "Warp"

echo "Development environment ready!"
