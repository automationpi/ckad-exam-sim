### Exercise 1: Basic Kubernetes API Primitives

#### Objective
In this exercise, you will practice using basic Kubernetes API primitives, including creating and managing Pods, ReplicationControllers, and ReplicaSets.

#### Scenario

You are required to create and manage basic Kubernetes API primitives. This includes creating and verifying the status of Pods, ReplicationControllers, and ReplicaSets.

##### Steps

1. Create a namespace `ckad-exercise-1`.
2. Create a Pod named `nginx-pod` using the Nginx image.
3. Create a ReplicationController named `nginx-rc` with 3 replicas using the Nginx image.
4. Create a ReplicaSet named `nginx-rs` with 3 replicas using the Nginx image.
5. Verify the status of the Pod, ReplicationController, and ReplicaSet.

#### Solution

1. Create a namespace `ckad-exercise-1`:
   ```sh
   kubectl create namespace ckad-exercise-1
   ```

2. Create a Pod named `nginx-pod` using the Nginx image:
   ```sh
   kubectl apply -f - <<EOF
   apiVersion: v1
   kind: Pod
   metadata:
     name: nginx-pod
     namespace: ckad-exercise-1
   spec:
     containers:
     - name: nginx
       image: nginx:latest
       ports:
       - containerPort: 80
   EOF
   ```

3. Create a ReplicationController named `nginx-rc` with 3 replicas:
   ```sh
   kubectl apply -f - <<EOF
   apiVersion: v1
   kind: ReplicationController
   metadata:
     name: nginx-rc
     namespace: ckad-exercise-1
   spec:
     replicas: 3
     selector:
       app: nginx
     template:
       metadata:
         labels:
           app: nginx
       spec:
         containers:
         - name: nginx
           image: nginx:latest
           ports:
           - containerPort: 80
   EOF
   ```

4. Create a ReplicaSet named `nginx-rs` with 3 replicas:
   ```sh
   kubectl apply -f - <<EOF
   apiVersion: apps/v1
   kind: ReplicaSet
   metadata:
     name: nginx-rs
     namespace: ckad-exercise-1
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
           image: nginx:latest
           ports:
           - containerPort: 80
   EOF
   ```

5. Verify the status of the Pod, ReplicationController, and ReplicaSet:
   ```sh
   kubectl get pod nginx-pod -n ckad-exercise-1
   kubectl get rc nginx-rc -n ckad-exercise-1
   kubectl get rs nginx-rs -n ckad-exercise-1
   ```

---

### Exercise 2: Deployments and Rolling Updates

#### Objective
In this exercise, you will practice creating, updating, and managing Deployments in Kubernetes. You will also perform rolling updates and rollbacks to understand how to manage application updates smoothly.

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

#### Solution

1. Create a namespace `ckad-exercise-2`:
   ```sh
   kubectl create namespace ckad-exercise-2
   ```

2. Create a Deployment named `nginx-deployment` with 3 replicas:
   ```sh
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
   ```

3. Verify the Deployment and ensure all replicas are running:
   ```sh
   kubectl get deployment nginx-deployment -n ckad-exercise-2
   ```

4. Update the Deployment to use the `nginx:1.16.1` image:
   ```sh
   kubectl set image deployment/nginx-deployment nginx=nginx:1.16.1 -n ckad-exercise-2
   ```

5. Verify that the rolling update has been performed successfully:
   ```sh
   kubectl rollout status deployment/nginx-deployment -n ckad-exercise-2
   ```

6. Roll back the Deployment to the previous version:
   ```sh
   kubectl rollout undo deployment/nginx-deployment -n ckad-exercise-2
   ```

7. Verify that the rollback has been completed and the Deployment is using the original image:
   ```sh
   kubectl get deployment nginx-deployment -n ckad-exercise-2
   ```

---

### Exercise 3: Namespaces and Contexts

#### Objective
In this exercise, you will practice creating and managing Kubernetes namespaces and contexts. You will learn to switch between different contexts and work with multiple namespaces effectively.

#### Scenario

You need to manage different environments (development and production) in Kubernetes by using namespaces and contexts. This will help you isolate resources and manage configurations for different stages of the application lifecycle.

##### Steps

1. Create namespaces `dev` and `prod`.
2. Create contexts `dev-context` and `prod-context` for the `dev` and `prod` namespaces, respectively.
3. Switch to `dev-context` and create a Deployment named `dev-nginx` using the `nginx:latest` image.
4. Switch to `prod-context` and create a Deployment named `prod-nginx` using the `nginx:latest` image.
5. Verify that each Deployment is created in the correct namespace by listing the Deployments in both `dev` and `prod` namespaces.

#### Solution

1. Create namespaces `dev` and `prod`:
   ```sh
   kubectl create namespace dev
   kubectl create namespace prod
   ```

2. Create contexts `dev-context` and `prod-context` for the `dev` and `prod` namespaces, respectively:
   ```sh
   kubectl config set-context dev-context --namespace=dev --cluster=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}') --user=$(kubectl config view --minify -o jsonpath='{.users[0].name}')
   kubectl config set-context prod-context --namespace=prod --cluster=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}') --user=$(kubectl config view --minify -o jsonpath='{.users[0].name}')
   ```

3. Switch to `dev-context` and create a Deployment named `dev-nginx`:
   ```sh
   kubectl config use-context dev-context
   kubectl create deployment dev-nginx --image=nginx:latest -n dev
   ```

4. Switch to `prod-context` and create a Deployment named `prod-nginx`:
   ```sh
   kubectl config use-context prod-context
   kubectl create deployment prod-nginx --image=nginx:latest -n prod
   ```

5. Verify that each Deployment is created in the correct namespace:
   ```sh
   kubectl get deployments -n dev
   kubectl get deployments -n prod
   ```

---

### Exercise 4: Resource Quotas and Limits

#### Objective
In this exercise, you will practice defining and applying resource quotas and limits in Kubernetes. You will monitor resource usage within namespaces to ensure that applications do not exceed allocated resources.

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
   - Memory limit: 500

Mi
4. Verify that the Deployment is created and all replicas are running within the specified resource limits.
5. Attempt to scale the Deployment to 5 replicas and observe the behavior due to resource quota constraints.

#### Solution

1. Create a namespace `ckad-exercise-4`:
   ```sh
   kubectl create namespace ckad-exercise-4
   ```

2. Apply a `ResourceQuota` named `mem-cpu-quota`:
   ```sh
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
   ```

3. Create a Deployment named `quota-test` with 3 replicas:
   ```sh
   kubectl apply -f - <<EOF
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: quota-test
     namespace: ckad-exercise-4
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
           image: nginx:latest
           resources:
             requests:
               cpu: "0.5"
               memory: "200Mi"
             limits:
               cpu: "1"
               memory: "500Mi"
           ports:
           - containerPort: 80
   EOF
   ```

4. Verify that the Deployment is created and all replicas are running:
   ```sh
   kubectl get deployment quota-test -n ckad-exercise-4
   ```

5. Attempt to scale the Deployment to 5 replicas and observe the behavior:
   ```sh
   kubectl scale deployment quota-test --replicas=5 -n ckad-exercise-4
   kubectl get deployment quota-test -n ckad-exercise-4
   ```

---

### Exercise 5: ConfigMaps and Secrets

#### Objective
In this exercise, you will practice creating and using ConfigMaps and Secrets in Kubernetes. You will inject configuration data and sensitive information into Pods using environment variables and volumes.

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

#### Solution

1. Create a namespace `ckad-exercise-5`:
   ```sh
   kubectl create namespace ckad-exercise-5
   ```

2. Create a ConfigMap named `my-config`:
   ```sh
   kubectl create configmap my-config --from-literal=app.name=myapp --from-literal=app.environment=production -n ckad-exercise-5
   ```

3. Create a Secret named `my-secret`:
   ```sh
   kubectl create secret generic my-secret --from-literal=username=admin --from-literal=password=s3cr3t -n ckad-exercise-5
   ```

4. Create a Pod named `config-secret-pod`:
   ```sh
   kubectl apply -f - <<EOF
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
   EOF
   ```

5. Verify that the Pod correctly uses the ConfigMap and Secret:
   ```sh
   kubectl get pod config-secret-pod -n ckad-exercise-5
   kubectl exec config-secret-pod -n ckad-exercise-5 -- printenv APP_NAME APP_ENVIRONMENT USERNAME PASSWORD
   kubectl exec config-secret-pod -n ckad-exercise-5 -- cat /etc/config/app.name
   kubectl exec config-secret-pod -n ckad-exercise-5 -- cat /etc/config/app.environment
   kubectl exec config-secret-pod -n ckad-exercise-5 -- cat /etc/secret/username
   kubectl exec config-secret-pod -n ckad-exercise-5 -- cat /etc/secret/password
   ```

---
