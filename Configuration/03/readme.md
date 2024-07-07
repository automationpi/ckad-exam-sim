### Exercise 3: Defining and Utilizing Security Settings

#### Objective
In this exercise, you will define and utilize security settings in Kubernetes. You will create and use NetworkPolicies to control the traffic between pods.

#### Scenario

You need to create NetworkPolicies to allow traffic only from specific pods to your application pods. You will also test the NetworkPolicies to ensure they are correctly configured.

##### Steps

1. Create a namespace `ckad-exercise-config-3`.
2. Deploy a sample application in the namespace.
3. Create a NetworkPolicy to allow traffic only from specific pods.
4. Verify that the NetworkPolicy is enforced correctly.

#### Solution

1. Create a namespace `ckad-exercise-config-3`:
   ```sh
   kubectl create namespace ckad-exercise-config-3
   ```

2. Deploy a sample application in the namespace:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: web-deployment
     namespace: ckad-exercise-config-3
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: web
     template:
       metadata:
         labels:
           app: web
       spec:
         containers:
         - name: web
           image: nginx
           ports:
           - containerPort: 80
   ```
   ```sh
   kubectl apply -f web-deployment.yaml
   ```

3. Create a NetworkPolicy to allow traffic only from specific pods:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: NetworkPolicy
   metadata:
     name: allow-specific
     namespace: ckad-exercise-config-3
   spec:
     podSelector:
       matchLabels:
         app: web
     policyTypes:


     - Ingress
     ingress:
     - from:
       - podSelector:
           matchLabels:
             role: allowed
       ports:
       - protocol: TCP
         port: 80
   ```
   ```sh
   kubectl apply -f allow-specific.yaml
   ```

4. Verify that the NetworkPolicy is enforced correctly:
   ```sh
   kubectl run test-pod --rm -it --image=busybox --namespace=ckad-exercise-config-3 --labels="role=allowed" -- sh
   wget -qO- http://web-deployment
   exit
   ```

   ```sh
   kubectl run test-pod --rm -it --image=busybox --namespace=ckad-exercise-config-3 --labels="role=blocked" -- sh
   wget -qO- http://web-deployment
   exit
   ```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

---
