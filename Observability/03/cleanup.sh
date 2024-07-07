#!/bin/bash

# Delete the Deployment
kubectl delete deployment faulty-deployment -n ckad-scenario-9

# Delete the namespace
kubectl delete namespace ckad-scenario-9

echo "Cleanup complete. Your environment has been reset."
