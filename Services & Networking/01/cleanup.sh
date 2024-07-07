#!/bin/bash

# Delete the Deployment and Service
kubectl delete deployment web-deployment -n ckad-scenario-17
kubectl delete service web-service -n ckad-scenario-17
kubectl delete pod curl-pod -n ckad-scenario-17

# Delete the namespace
kubectl delete namespace ckad-scenario-17

echo "Cleanup complete. Your environment has been reset."
