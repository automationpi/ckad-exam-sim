#!/bin/bash

# Delete the Prometheus and Grafana deployments
kubectl delete deployment prometheus-operator -n ckad-scenario-8
kubectl delete deployment grafana -n ckad-scenario-8

# Delete the sample application
kubectl delete pod metrics-app -n ckad-scenario-8
kubectl delete service metrics-app -n ckad-scenario-8

# Delete the namespace
kubectl delete namespace ckad-scenario-8

echo "Cleanup complete. Your environment has been reset."
