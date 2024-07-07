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

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Pod Security Policies](https://kubernetes.io/docs/concepts/policy/pod-security-policy/)
- [RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

---
