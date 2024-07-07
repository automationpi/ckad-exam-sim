#!/bin/bash

# Delete the Deployment, Service, and NetworkPolicies
kubectl delete deployment web-deployment -n ckad-scenario-18
kubectl delete service web-service -n ckad-scenario-18
kubectl delete networkpolicy default-deny -n ckad-scenario-18
kubectl delete networkpolicy allow-curl -n ckad-scenario-18
kubectl delete pod curl-pod -n ckad-scenario-18

# Delete the namespace
kubectl delete namespace ckad-scenario-18

echo "Cleanup complete. Your environment has been reset."
