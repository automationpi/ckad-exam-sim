#!/bin/bash

# Delete the Pod
kubectl delete pod config-secret-pod -n ckad-exercise-5

# Delete the ConfigMap
kubectl delete configmap my-config -n ckad-exercise-5

# Delete the Secret
kubectl delete secret my-secret -n ckad-exercise-5

# Delete the namespace
kubectl delete namespace ckad-exercise-5

echo "Cleanup complete. Your environment has been reset."
