#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-exercise-5

# Create a ConfigMap
kubectl create configmap my-config --from-literal=app.name=myapp --from-literal=app.environment=production -n ckad-exercise-5

# Create a Secret
kubectl create secret generic my-secret --from-literal=username=admin --from-literal=password=s3cr3t -n ckad-exercise-5

echo "Setup complete. Your environment is ready."
