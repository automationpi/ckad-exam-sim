### Exercise 4: Resource Quotas and Limits

#### Objective
In this exercise, you will practice defining and applying resource quotas and limits in Kubernetes. You will monitor resource usage within namespaces to ensure that applications do not exceed allocated resources.

#### Setup Script (`setup.sh`)

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-exercise-4

# Apply a ResourceQuota
kubectl apply -f - <<EOF
apiVersion: v1
kind: ResourceQuota
metadata:
  name: mem-cpu-quota
  namespace: ckad-exercise-4
spec:
  hard:
    requests.cpu: "2"
    requests.memory: 1Gi
    limits.cpu: "4"
    limits.memory: 2Gi
EOF

echo "Setup complete. Your environment is ready."
```

#### Scenario

You need to ensure that applications running in a Kubernetes namespace do not exceed specific resource limits. This involves applying resource quotas and limits, and monitoring their usage.

##### Steps

1. Create a namespace `ckad-exercise-4`.
2. Apply a `ResourceQuota` named `mem-cpu-quota` in the namespace with the following limits:
   - CPU requests: 2
   - Memory requests: 1Gi
   - CPU limits: 4
   - Memory limits: 2Gi
3. Create a Deployment named `quota-test` with 3 replicas using the `nginx:latest` image. Set resource requests and limits for the containers as follows:
   - CPU request: 0.5
   - Memory request: 200Mi
   - CPU limit: 1
   - Memory limit: 500Mi
4. Verify that the Deployment is created and all replicas are running within the specified resource limits.
5. Attempt to scale the Deployment to 5 replicas and observe the behavior due to resource quota constraints.

#### Verification

- Confirm the `ResourceQuota` is applied in the namespace.
- Verify the `quota-test` Deployment is running with 3 replicas.
- Observe the behavior when scaling the Deployment to 5 replicas and ensure it adheres to the resource quotas.

#### Cleanup Script (`cleanup.sh`)

```sh
#!/bin/bash

# Delete the Deployment
kubectl delete deployment quota-test -n ckad-exercise-4

# Delete the ResourceQuota
kubectl delete resourcequota mem-cpu-quota -n ckad-exercise-4

# Delete the namespace
kubectl delete namespace ckad-exercise-4

echo "Cleanup complete. Your environment has been reset."
```

#### Documentation and Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Resource Quotas](https://kubernetes.io/docs/concepts/policy/resource-quotas/)
- [Managing Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/)

#### Expectations

- Understand how to define and apply resource quotas in Kubernetes.
- Gain experience in setting resource requests and limits for containers.
- Learn to monitor resource usage and ensure applications adhere to resource constraints.

---

This exercise will help you manage and enforce resource limits within a Kubernetes namespace. 
