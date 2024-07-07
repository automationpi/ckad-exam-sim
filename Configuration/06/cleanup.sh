#!/bin/bash

# Delete the Deployment
kubectl delete deployment quota-test -n ckad-scenario-3

# Delete the ResourceQuota
kubectl delete resourcequota mem-cpu-quota -n ckad-scenario-3

# Delete the namespace
kubectl delete namespace ckad-scenario-3

echo "Cleanup complete. Your environment has been reset."
