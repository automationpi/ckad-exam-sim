#!/bin/bash

# Delete the ReplicaSet
kubectl delete replicaset myapp-replicaset -n ckad-scenario-12

# Delete the namespace
kubectl delete namespace ckad-scenario-12

echo "Cleanup complete. Your environment has been reset."
