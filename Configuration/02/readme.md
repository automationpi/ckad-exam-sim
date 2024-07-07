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

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/)
- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)

---
