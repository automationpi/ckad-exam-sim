#!/bin/bash

# Delete the Pod
kubectl delete pod labeled-pod -n ckad-scenario-10

# Delete the namespace
kubectl delete namespace ckad-scenario-10

echo "Cleanup complete. Your environment has been reset."
