#!/bin/bash

# Delete the Deployment
kubectl delete deployment probes-deployment -n ckad-scenario-11

# Delete the namespace
kubectl delete namespace ckad-scenario-11

echo "Cleanup complete. Your environment has been reset."
