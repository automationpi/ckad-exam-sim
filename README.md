# ckad-exam-sim
This repo contains exercises for CKAD exams

# CKAD Hands-On Exercises

## Introduction

The Certified Kubernetes Application Developer (CKAD) program is designed to help you demonstrate your proficiency in designing, building, configuring, and exposing cloud-native applications for Kubernetes. The exam focuses on the following key areas:

1. Core Concepts (13%)
2. Configuration (18%)
3. Multi-Container Pods (10%)
4. Observability (18%)
5. Pod Design (20%)
6. Services & Networking (13%)
7. State Persistence (8%)

This README provides a comprehensive set of hands-on exercises covering each section of the CKAD curriculum. These exercises are structured to simulate real-world scenarios and exam conditions, helping you practice and reinforce your knowledge.

## Exam Sections and Objectives

| Section                 | Weight | Objectives                                                                                     |
|-------------------------|--------|------------------------------------------------------------------------------------------------|
| Core Concepts           | 13%    | Understanding Kubernetes API primitives and architecture components                            |
| Configuration           | 18%    | Configuring settings and security, defining and utilizing resource and storage classes         |
| Multi-Container Pods    | 10%    | Understanding Pod design patterns and utilizing multi-container Pods                           |
| Observability           | 18%    | Monitoring and logging, troubleshooting application failures                                  |
| Pod Design              | 20%    | Using labels, selectors, and annotations, configuring Liveness and Readiness probes            |
| Services & Networking   | 13%    | Understanding and configuring networking, creating and managing network policies                |
| State Persistence       | 8%     | Configuring and managing persistent storage, understanding storage classes and PersistentVolumeClaims |

## How to Use These Exercises

1. **Setup:** Each exercise comes with a setup script that prepares the environment. Run the setup script to create necessary resources and configurations.
2. **Exercise:** Follow the intermediate exercises to complete the given tasks. These tasks are designed to mimic real-world scenarios you may encounter in the CKAD exam.
3. **Solution:** Solutions are provided to help you verify your work and understand the correct approach to solving each problem.
4. **Cleanup:** After completing the exercises, run the cleanup script to reset the environment. This ensures that there are no leftover resources that could interfere with future exercises.

## Structure of the Exercises

Each section contains multiple scenarios, each with the following structure:
- **Setup Script:** Prepares the environment for the exercise.
- **Intermediate Exercise:** Describes the tasks you need to complete.
- **Solution:** Provides the correct solution to the tasks.
- **Cleanup Script:** Resets the environment by deleting resources created during the setup.

## Cheat sheet

Here is a cheat sheet for `kubectl` commands ranging from beginner to advanced levels.

| **Level**     | **Command**                                 | **Description**                                                                                 |
|---------------|---------------------------------------------|-------------------------------------------------------------------------------------------------|
| **Beginner**  | `kubectl version`                           | Display the Kubernetes client and server version information.                                   |
|               | `kubectl cluster-info`                      | Display cluster information.                                                                    |
|               | `kubectl get nodes`                         | List all nodes in the cluster.                                                                  |
|               | `kubectl get pods`                          | List all pods in the current namespace.                                                         |
|               | `kubectl get services`                      | List all services in the current namespace.                                                     |
|               | `kubectl describe pod <pod-name>`           | Display detailed information about a specific pod.                                              |
|               | `kubectl logs <pod-name>`                   | Print the logs for a container in a pod.                                                        |
|               | `kubectl apply -f <file.yaml>`              | Apply a configuration change defined in a YAML file.                                            |
|               | `kubectl delete pod <pod-name>`             | Delete a specific pod.                                                                          |
| **Intermediate** | `kubectl get pods -o wide`               | List all pods with additional information, such as node name.                                   |
|               | `kubectl get pods -n <namespace>`           | List all pods in a specific namespace.                                                          |
|               | `kubectl exec -it <pod-name> -- /bin/bash`  | Execute a command in a container within a pod.                                                  |
|               | `kubectl scale deployment <deployment-name> --replicas=<number>` | Scale a deployment to a specified number of replicas.                                          |
|               | `kubectl get events`                        | List events in the current namespace.                                                           |
|               | `kubectl describe service <service-name>`   | Display detailed information about a specific service.                                          |
|               | `kubectl port-forward <pod-name> <local-port>:<pod-port>` | Forward one or more local ports to a pod.                                                      |
|               | `kubectl create namespace <namespace-name>` | Create a new namespace.                                                                         |
| **Advanced**  | `kubectl top nodes`                         | Display resource (CPU/memory) usage of nodes.                                                   |
|               | `kubectl top pods`                          | Display resource (CPU/memory) usage of pods.                                                    |
|               | `kubectl get deployments`                   | List all deployments in the current namespace.                                                  |
|               | `kubectl rollout status deployment <deployment-name>` | Check the status of a deployment rollout.                                                    |
|               | `kubectl rollout undo deployment <deployment-name>`    | Undo a deployment rollout.                                                                 |
|               | `kubectl set image deployment/<deployment-name> <container-name>=<new-image>` | Update the image of a container in a deployment.                            |
|               | `kubectl get pv`                            | List all persistent volumes.                                                                    |
|               | `kubectl get pvc`                           | List all persistent volume claims.                                                              |
|               | `kubectl auth can-i <verb> <resource>`      | Check if the current user can perform an action on a resource.                                  |
|               | `kubectl api-resources`                     | List all available resource types in the API with their short names, API group, and kind.       |
|               | `kubectl edit <resource> <resource-name>`   | Edit a resource on the server.                                                                  |
|               | `kubectl taint nodes <node-name> <key>=<value>:<effect>` | Taint a node to repel specified pods.                                                         |
|               | `kubectl label nodes <node-name> <label-key>=<label-value>` | Add a label to a node.                                                                      |

This cheat sheet should help you navigate and utilize `kubectl` commands effectively from beginner to advanced levels.



These exercises are tailored to cover all the essential aspects of the CKAD curriculum. By completing these exercises, you will:
- Gain hands-on experience with Kubernetes.
- Understand the practical application of Kubernetes concepts.
- Reinforce your knowledge through real-world scenarios.
- Build confidence to tackle the CKAD exam.
