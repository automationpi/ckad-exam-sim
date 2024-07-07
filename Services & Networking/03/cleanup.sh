#!/bin/bash

# Delete the Deployment and Services
kubectl delete deployment web-deployment -n ckad-scenario-19
kubectl delete service web-loadbalancer -n ckad-scenario-19
kubectl delete service web-nodeport -n ckad-scenario-19

# Delete the namespace
kubectl delete namespace ckad-scenario-19

echo "Cleanup complete. Your environment has been reset."
