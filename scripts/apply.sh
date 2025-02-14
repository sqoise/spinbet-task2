#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Get current Terraform workspace
WORKSPACE=$(terraform workspace show)
TFVARS="tfvars/${WORKSPACE}.tfvars"

# Check if the workspace is valid
if [ -z "$WORKSPACE" ]; then
  echo "Error: Unable to determine Terraform workspace!"
  exit 1
fi

# Check if tfvars file exists
if [ ! -f "$TFVARS" ]; then
  echo "Error: Terraform variables file not found: $TFVARS"
  exit 1
fi

echo "Using workspace: $WORKSPACE"
echo "Applying Terraform configuration using: $TFVARS"

# Initialize Terraform (ensure required plugins are available)
echo "Initializing Terraform..."
terraform init -upgrade

# Ensure workspace is selected (or create if missing)
echo "Selecting Terraform workspace: $WORKSPACE"
terraform workspace select "$WORKSPACE" || terraform workspace new "$WORKSPACE"

# Run Terraform Plan
echo "Running Terraform Plan..."
terraform plan -var-file="$TFVARS"

# Confirm before applying
read -p "Proceed with deployment? (y/N): " CONFIRM
if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "🚀 Deploying Infrastructure..."
  terraform apply -var-file="$TFVARS" -auto-approve
  echo "Deployment completed successfully!"
else
  echo "Deployment cancelled."
  exit 1
fi
