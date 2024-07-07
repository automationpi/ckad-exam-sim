### Exercise 3: Namespaces and Contexts

#### Objective
In this exercise, you will practice creating and managing Kubernetes namespaces and contexts. You will learn to switch between different contexts and work with multiple namespaces effectively.

#### Setup Script (`setup.sh`)

```sh
#!/bin/bash

# Create namespaces for the exercise
kubectl create namespace ckad-exercise-3
kubectl create namespace dev
kubectl create namespace prod

# Create a context for each namespace
kubectl config set-context dev-context --namespace=dev --cluster=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}') --user=$(kubectl config view --minify -o jsonpath='{.users[0].name}')
kubectl config set-context prod-context --namespace=prod --cluster=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}') --user=$(kubectl config view --minify -o jsonpath='{.users[0].name}')

# Switch to the initial namespace context
kubectl config use-context $(kubectl config view --minify -o jsonpath='{.current-context}')

echo "Setup complete. Your environment is ready."
```

#### Scenario

You need to manage different environments (development and production) in Kubernetes by using namespaces and contexts. This will help you isolate resources and manage configurations for different stages of the application lifecycle.

##### Steps

1. Create namespaces `dev` and `prod`.
2. Create contexts `dev-context` and `prod-context` for the `dev` and `prod` namespaces, respectively.
3. Switch to `dev-context` and create a Deployment named `dev-nginx` using the `nginx:latest` image.
4. Switch to `prod-context` and create a Deployment named `prod-nginx` using the `nginx:latest` image.
5. Verify that each Deployment is created in the correct namespace by listing the Deployments in both `dev` and `prod` namespaces.

#### Verification

- Confirm that the `dev-nginx` Deployment exists in the `dev` namespace.
- Confirm that the `prod-nginx` Deployment exists in the `prod` namespace.
- Verify that switching between contexts allows you to manage resources in different namespaces seamlessly.

#### Cleanup Script (`cleanup.sh`)

```sh
#!/bin/bash

# Delete the Deployments in both namespaces
kubectl delete deployment dev-nginx -n dev
kubectl delete deployment prod-nginx -n prod

# Delete the namespaces
kubectl delete namespace dev
kubectl delete namespace prod
kubectl delete namespace ckad-exercise-3

# Remove the contexts
kubectl config delete-context dev-context
kubectl config delete-context prod-context

echo "Cleanup complete. Your environment has been reset."
```

#### Documentation and Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
- [Contexts](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/#context)

#### Expectations

- Understand how to create and manage Kubernetes namespaces.
- Gain experience in creating and switching between contexts.
- Learn to isolate and manage resources in different environments using namespaces and contexts.

---
