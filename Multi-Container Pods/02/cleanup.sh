#!/bin/bash

# Delete the Pod
kubectl delete pod ambassador-pod -n ckad-scenario-5

# Delete the Service
kubectl delete service ambassador-service -n ckad-scenario-5

# Delete the namespace
kubectl delete namespace ckad-scenario-5

echo "Cleanup complete. Your environment has been reset."
