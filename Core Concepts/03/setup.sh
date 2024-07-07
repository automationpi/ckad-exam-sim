#!/bin/bash

# Create namespaces for the exercise
kubectl create namespace ckad-exercise-3
kubectl create namespace dev
kubectl create namespace prod

# Create a context for each namespace
kubectl config set-context dev-context --namespace=dev --cluster=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}') --user=$(kubectl config view --minify -o jsonpath='{.users[0].name}')
kubectl config set-context prod-context --namespace=prod --cluster=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}') --user=$(kubectl config view --minify -o jsonpath='{.users[0].name}')

# Switch to the initial namespace context
kubectl config use-context $(kubectl config view --minify -o jsonpath='{.current-context}')

echo "Setup complete. Your environment is ready."
