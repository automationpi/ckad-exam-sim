#!/bin/bash

# Delete the Deployments in both namespaces
kubectl delete deployment dev-nginx -n dev
kubectl delete deployment prod-nginx -n prod

# Delete the namespaces
kubectl delete namespace dev
kubectl delete namespace prod
kubectl delete namespace ckad-exercise-3

# Remove the contexts
kubectl config delete-context dev-context
kubectl config delete-context prod-context

echo "Cleanup complete. Your environment has been reset."
