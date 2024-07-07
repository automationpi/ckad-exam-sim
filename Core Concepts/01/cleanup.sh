#!/bin/bash

# Delete the Pod
kubectl delete pod nginx-pod -n ckad-exercise-1

# Delete the ReplicationController
kubectl delete rc nginx-rc -n ckad-exercise-1

# Delete the ReplicaSet
kubectl delete rs nginx-rs -n ckad-exercise-1

# Delete the namespace
kubectl delete namespace ckad-exercise-1

echo "Cleanup complete. Your environment has been reset."
