#!/bin/bash

# Delete the Deployment
kubectl delete deployment quota-test -n ckad-exercise-4

# Delete the ResourceQuota
kubectl delete resourcequota mem-cpu-quota -n ckad-exercise-4

# Delete the namespace
kubectl delete namespace ckad-exercise-4

echo "Cleanup complete. Your environment has been reset."
