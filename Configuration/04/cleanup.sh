#!/bin/bash

# Delete the Pods
kubectl delete pod restricted-pod -n ckad-scenario-1
kubectl delete pod allowed-pod -n ckad-scenario-1
kubectl delete pod blocked-pod -n ckad-scenario-1

# Delete the Deployment
kubectl delete deployment web-deployment -n ckad-scenario-1

# Delete the NetworkPolicy
kubectl delete networkpolicy allow-specific -n ckad-scenario-1

# Delete the PodSecurityPolicy
kubectl delete podsecuritypolicy restricted-psp

# Delete the Role and RoleBinding
kubectl delete role psp-role -n ckad-scenario-1
kubectl delete rolebinding psp-rolebinding -n ckad-scenario-1

# Delete the namespace
kubectl delete namespace ckad-scenario-1

echo "Cleanup complete. Your environment has been reset."
