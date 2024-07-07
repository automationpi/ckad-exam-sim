### Exercise 2: Deployments and Rolling Updates

#### Objective
In this exercise, you will practice creating, updating, and managing Deployments in Kubernetes. You will also perform rolling updates and rollbacks to understand how to manage application updates smoothly.

#### Setup Script (`setup.sh`)

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-exercise-2

# Create a Deployment
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: ckad-exercise-2
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
EOF

echo "Setup complete. Your environment is ready."
```

#### Scenario

You need to deploy a web server application using Kubernetes Deployments. You will create a Deployment, update it to a new version, and then roll back to the previous version to ensure zero downtime and smooth updates.

##### Steps

1. Create a namespace `ckad-exercise-2`.
2. Create a Deployment named `nginx-deployment` with 3 replicas using the `nginx:1.14.2` image.
3. Verify the Deployment and ensure all replicas are running.
4. Update the Deployment to use the `nginx:1.16.1` image.
5. Verify that the rolling update has been performed successfully.
6. Roll back the Deployment to the previous version (`nginx:1.14.2`).
7. Verify that the rollback has been completed and the Deployment is using the original image.

#### Verification

- Check the status of the Deployment to ensure all replicas are running.
- Confirm the image has been updated to `nginx:1.16.1`.
- Verify the rollback has reverted the image to `nginx:1.14.2`.

#### Cleanup Script (`cleanup.sh`)

```sh
#!/bin/bash

# Delete the Deployment
kubectl delete deployment nginx-deployment -n ckad-exercise-2

# Delete the namespace
kubectl delete namespace ckad-exercise-2

echo "Cleanup complete. Your environment has been reset."
```

#### Documentation and Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)
- [Rolling Updates](https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/)
- [Rollbacks](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-back-a-deployment)

#### Expectations

- Understand how to create and manage Kubernetes Deployments.
- Gain experience in performing rolling updates to smoothly transition between application versions.
- Learn how to roll back to previous versions in case of failures during updates.

---
