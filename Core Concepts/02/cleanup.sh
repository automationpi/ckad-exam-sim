#!/bin/bash

# Delete the Deployment
kubectl delete deployment nginx-deployment -n ckad-exercise-2

# Delete the namespace
kubectl delete namespace ckad-exercise-2

echo "Cleanup complete. Your environment has been reset."
