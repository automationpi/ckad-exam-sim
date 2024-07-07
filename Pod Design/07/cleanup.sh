#!/bin/bash

# Delete the Deployment
kubectl delete deployment affinity-deployment -n ckad-scenario-16

# Delete the namespace
kubectl delete namespace ckad-scenario-16

echo "Cleanup complete. Your environment has been reset."
