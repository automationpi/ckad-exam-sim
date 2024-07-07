#!/bin/bash

# Delete the Deployment, Service, and Ingress
kubectl delete deployment web-deployment -n ckad-scenario-20
kubectl delete service web-service -n ckad-scenario-20
kubectl delete ingress web-ingress -n ckad-scenario-20

# Delete the namespace
kubectl delete namespace ckad-scenario-20

echo "Cleanup complete. Your environment has been reset."
