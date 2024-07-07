### Exercise 5: ConfigMaps and Secrets

#### Objective
In this exercise, you will practice creating and using ConfigMaps and Secrets in Kubernetes. You will inject configuration data and sensitive information into Pods using environment variables and volumes.

#### Setup Script (`setup.sh`)

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-exercise-5

# Create a ConfigMap
kubectl create configmap my-config --from-literal=app.name=myapp --from-literal=app.environment=production -n ckad-exercise-5

# Create a Secret
kubectl create secret generic my-secret --from-literal=username=admin --from-literal=password=s3cr3t -n ckad-exercise-5

echo "Setup complete. Your environment is ready."
```

#### Scenario

You need to manage configuration data and sensitive information securely in Kubernetes. This involves creating ConfigMaps and Secrets and injecting them into Pods using environment variables and volumes.

##### Steps

1. Create a namespace `ckad-exercise-5`.
2. Create a ConfigMap named `my-config` with the following data:
   - `app.name=myapp`
   - `app.environment=production`
3. Create a Secret named `my-secret` with the following data:
   - `username=admin`
   - `password=s3cr3t`
4. Create a Pod named `config-secret-pod` that uses the ConfigMap and Secret as environment variables and volumes.
5. Verify that the Pod correctly uses the ConfigMap and Secret.

##### Pod Specification

Here is a sample Pod specification to use:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: config-secret-pod
  namespace: ckad-exercise-5
spec:
  containers:
  - name: my-container
    image: nginx:latest
    env:
    - name: APP_NAME
      valueFrom:
        configMapKeyRef:
          name: my-config
          key: app.name
    - name: APP_ENVIRONMENT
      valueFrom:
        configMapKeyRef:
          name: my-config
          key: app.environment
    - name: USERNAME
      valueFrom:
        secretKeyRef:
          name: my-secret
          key: username
    - name: PASSWORD
      valueFrom:
        secretKeyRef:
          name: my-secret
          key: password
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config
      readOnly: true
    - name: secret-volume
      mountPath: /etc/secret
      readOnly: true
  volumes:
  - name: config-volume
    configMap:
      name: my-config
  - name: secret-volume
    secret:
      secretName: my-secret
```

#### Verification

- Verify that the ConfigMap and Secret are correctly created and contain the expected data.
- Confirm the Pod is running and the environment variables are set correctly.
- Check the mounted volumes to ensure they contain the ConfigMap and Secret data.

#### Cleanup Script (`cleanup.sh`)

```sh
#!/bin/bash

# Delete the Pod
kubectl delete pod config-secret-pod -n ckad-exercise-5

# Delete the ConfigMap
kubectl delete configmap my-config -n ckad-exercise-5

# Delete the Secret
kubectl delete secret my-secret -n ckad-exercise-5

# Delete the namespace
kubectl delete namespace ckad-exercise-5

echo "Cleanup complete. Your environment has been reset."
```

#### Documentation and Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [ConfigMaps](https://kubernetes.io/docs/concepts/configuration/configmap/)
- [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)

#### Expectations

- Understand how to create and manage ConfigMaps and Secrets in Kubernetes.
- Gain experience in injecting configuration data and sensitive information into Pods using environment variables and volumes.
- Learn to verify and troubleshoot the use of ConfigMaps and Secrets in Pods.

---
