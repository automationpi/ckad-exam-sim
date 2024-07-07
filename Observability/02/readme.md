### Scenario 2: Monitoring with Prometheus and Grafana

#### Setup Script

```sh
#!/bin/bash

# Create a namespace for the exercise
kubectl create namespace ckad-scenario-8

# Deploy Prometheus
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/master/bundle.yaml -n ckad-scenario-8

# Deploy Grafana
kubectl apply -f https://raw.githubusercontent.com/grafana/grafana/master/deploy/kubernetes/grafana-deployment.yaml -n ckad-scenario-8

echo "Setup complete. Your environment is ready."
```

#### Intermediate Exercise

1. Verify that Prometheus and Grafana are running in the `ckad-scenario-8` namespace.
2. Forward ports to access Prometheus and Grafana dashboards locally.
3. Configure Prometheus to scrape metrics from a sample application.
4. Create a simple Grafana dashboard to visualize the metrics.

##### Solution

1. Verify that Prometheus and Grafana are running:
   ```sh
   kubectl get pods -n ckad-scenario-8
   ```

2. Forward ports to access Prometheus and Grafana dashboards:
   ```sh
   kubectl port-forward -n ckad-scenario-8 svc/prometheus 9090:9090 &
   kubectl port-forward -n ckad-scenario-8 svc/grafana 3000:3000 &
   ```
   Access Prometheus at `http://localhost:9090` and Grafana at `http://localhost:3000`.

3. Configure Prometheus to scrape metrics from a sample application:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: metrics-app
     namespace: ckad-scenario-8
     labels:
       app: metrics-app
   spec:
     containers:
     - name: metrics-app
       image: prom/statsd-exporter
       ports:
       - containerPort: 9102
   ```
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: metrics-app
     namespace: ckad-scenario-8
     labels:
       app: metrics-app
   spec:
     ports:
     - port: 9102
       targetPort: 9102
     selector:
       app: metrics-app
   ```
   ```sh
   kubectl apply -f metrics-app.yaml
   kubectl apply -f metrics-app-service.yaml
   ```

4. Add the following scrape configuration to Prometheus:
   ```yaml
   scrape_configs:
   - job_name: 'metrics-app'
     static_configs:
     - targets: ['metrics-app.ckad-scenario-8.svc.cluster.local:9102']
   ```
   Reload Prometheus configuration.

5. Create a simple Grafana dashboard:
   - Add Prometheus as a data source in Grafana.
   - Create a new dashboard and add a graph panel.
   - Query for metrics from `metrics-app`.

#### Cleanup Script

```sh
#!/bin/bash

# Delete the Prometheus and Grafana deployments
kubectl delete deployment prometheus-operator -n ckad-scenario-8
kubectl delete deployment grafana -n ckad-scenario-8

# Delete the sample application
kubectl delete pod metrics-app -n ckad-scenario-8
kubectl delete service metrics-app -n ckad-scenario-8

# Delete the namespace
kubectl delete namespace ckad-scenario-8

echo "Cleanup complete. Your environment has been reset."
```

#### References and Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator)
- [Grafana](https://grafana.com/)
- [Monitoring with Prometheus](https://kubernetes.io/docs/tasks/debug-application-cluster/resource-metrics-pipeline/)

---
