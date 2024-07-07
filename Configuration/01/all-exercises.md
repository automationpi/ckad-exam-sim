### Exercise 1: Configuring and Validating Settings and Security

#### Objective
In this exercise, you will practice configuring settings and security in Kubernetes. You will create and validate a PodSecurityPolicy to enforce security settings on your pods.

#### Scenario

You need to create and apply a PodSecurityPolicy to ensure that pods do not run as the root user. You will also validate that the policy is enforced correctly.

##### Steps

1. Create a namespace `ckad-exercise-config-1`.
2. Create a PodSecurityPolicy named `restricted-psp` that disallows running as the root user.
3. Create a Role and RoleBinding to grant permissions to use the `restricted-psp` within the namespace.
4. Create a ServiceAccount and bind it to the RoleBinding.
5. Create a Pod that attempts to run as the root user and verify that it is denied.
6. Create a Pod that runs as a non-root user and verify that it is allowed.

#### Solution

1. Create a namespace `ckad-exercise-config-1`:
   ```sh
   kubectl create namespace ckad-exercise-config-1
   ```

2. Create a PodSecurityPolicy named `restricted-psp`:
   ```yaml
   apiVersion: policy/v1beta1
   kind: PodSecurityPolicy
   metadata:
     name: restricted-psp
   spec:
     privileged: false
     allowPrivilegeEscalation: false
     runAsUser:
       rule: 'MustRunAsNonRoot'
     seLinux:
       rule: 'RunAsAny'
     supplementalGroups:
       rule: 'MustRunAs'
       ranges:
       - min: 1
         max: 65535
     fsGroup:
       rule: 'MustRunAs'
       ranges:
       - min: 1
         max: 65535
     volumes:
     - 'configMap'
     - 'emptyDir'
     - 'projected'
     - 'secret'
     - 'downwardAPI'
   ```
   ```sh
   kubectl apply -f restricted-psp.yaml
   ```

3. Create a Role and RoleBinding to grant permissions to use the `restricted-psp`:
   ```yaml
   apiVersion: rbac.authorization.k8s.io/v1
   kind: Role
   metadata:
     name: psp-role
     namespace: ckad-exercise-config-1
   rules:
   - apiGroups:
     - policy
     resources:
     - podsecuritypolicies
     verbs:
     - use
     resourceNames:
     - restricted-psp
   ```
   ```sh
   kubectl apply -f psp-role.yaml
   ```

4. Create a RoleBinding:
   ```yaml
   apiVersion: rbac.authorization.k8s.io/v1
   kind: RoleBinding
   metadata:
     name: psp-rolebinding
     namespace: ckad-exercise-config-1
   subjects:
   - kind: ServiceAccount
     name: default
     namespace: ckad-exercise-config-1
   roleRef:
     kind: Role
     name: psp-role
     apiGroup: rbac.authorization.k8s.io
   ```
   ```sh
   kubectl apply -f psp-rolebinding.yaml
   ```

5. Create a Pod that attempts to run as the root user and verify that it is denied:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: root-pod
     namespace: ckad-exercise-config-1
   spec:
     containers:
     - name: nginx
       image: nginx
       securityContext:
         runAsUser: 0
   ```
   ```sh
   kubectl apply -f root-pod.yaml
   kubectl get pod root-pod -n ckad-exercise-config-1
   ```

6. Create a Pod that runs as a non-root user and verify that it is allowed:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: nonroot-pod
     namespace: ckad-exercise-config-1
   spec:
     containers:
     - name: nginx
       image: nginx
       securityContext:
         runAsUser: 1000
   ```
   ```sh
   kubectl apply -f nonroot-pod.yaml
   kubectl get pod nonroot-pod -n ckad-exercise-config-1
   ```

---

### Exercise 2: Defining and Utilizing Resource Classes

#### Objective
In this exercise, you will practice defining and utilizing resource classes in Kubernetes. You will create and use a custom StorageClass to provision PersistentVolumes dynamically.

#### Scenario

You need to create a custom StorageClass and use it to provision PersistentVolumes dynamically for your applications.

##### Steps

1. Create a namespace `ckad-exercise-config-2`.
2. Create a custom StorageClass named `fast-storage`.
3. Create a PersistentVolumeClaim that uses the `fast-storage` StorageClass.
4. Verify that a PersistentVolume is dynamically provisioned and bound to the PersistentVolumeClaim.
5. Create a Pod that uses the PersistentVolumeClaim.

#### Solution

1. Create a namespace `ckad-exercise-config-2`:
   ```sh
   kubectl create namespace ckad-exercise-config-2
   ```

2. Create a custom StorageClass named `fast-storage`:
   ```yaml
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: fast-storage
   provisioner: kubernetes.io/no-provisioner
   volumeBindingMode: WaitForFirstConsumer
   ```
   ```sh
   kubectl apply -f fast-storage.yaml
   ```

3. Create a PersistentVolumeClaim that uses the `fast-storage` StorageClass:
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: fast-pvc
     namespace: ckad-exercise-config-2
   spec:
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
         storage: 1Gi
     storageClassName: fast-storage
   ```
   ```sh
   kubectl apply -f fast-pvc.yaml
   ```

4. Verify that a PersistentVolume is dynamically provisioned and bound to the PersistentVolumeClaim:
   ```sh
   kubectl get pvc fast-pvc -n ckad-exercise-config-2
   kubectl get pv
   ```

5. Create a Pod that uses the PersistentVolumeClaim:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: pvc-pod
     namespace: ckad-exercise-config-2
   spec:
     containers:
     - name: my-container
       image: nginx
       volumeMounts:
       - mountPath: "/usr/share/nginx/html"
         name: my-volume
     volumes:
     - name: my-volume
       persistentVolumeClaim:
         claimName: fast-pvc
   ```
   ```sh
   kubectl apply -f pvc-pod.yaml
   kubectl get pod pvc-pod -n ckad-exercise-config-2
   ```

---

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
   kubectl run test-pod --rm -it --image=busybox --namespace=ckad-exercise-config-3 --labels="role=allowed" --

 sh
   wget -qO- http://web-deployment
   exit
   ```

   ```sh
   kubectl run test-pod --rm -it --image=busybox --namespace=ckad-exercise-config-3 --labels="role=blocked" -- sh
   wget -qO- http://web-deployment
   exit
   ```

---
