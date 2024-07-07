#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-8

# Deploy Prometheus
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/master/bundle.yaml -n ckad-scenario-8

# Deploy Grafana
kubectl apply -f https://raw.githubusercontent.com/grafana/grafana/master/deploy/kubernetes/grafana-deployment.yaml -n ckad-scenario-8

echo "Setup complete. Your environment is ready."
