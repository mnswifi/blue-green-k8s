# Blue-Green Deployment on Kubernetes

## Overview

This project demonstrates a blue-green deployment strategy using Kubernetes with a simple Python Flask app.

## Structure

- `app/`: Source code for the demo app
- `Dockerfile`: Container build file
- `deployments/`: Kubernetes manifests for blue/green deployments and service
- `scripts/`: Automation scripts
- `.github/workflows/`: CI/CD pipeline

```bash

blue-green-k8s/
├── app/
│   └── main.py
├── deployments/
│   ├── blue-deployment.yaml
│   ├── green-deployment.yaml
│   └── service.yaml
├── scripts/
│   ├── switch.sh
│   ├── test.sh
│   └── export_manifests.sh
├── Dockerfile
├── README.md
└── .github/
    └── workflows/
        └── ci-cd.yaml

```

## Setup Instructions

### 1. Build and Push Docker Images

Replace `mydockerhubusername` with your Docker Hub username.

```bash
docker build -t mydockerhubusername/blue-green-demo:blue --build-arg COLOR=blue .
docker build -t mydockerhubusername/blue-green-demo:green --build-arg COLOR=green .
docker push mydockerhubusername/blue-green-demo:blue
docker push mydockerhubusername/blue-green-demo:green
```

### 2. Deploy to Kubernetes

```bash
kubectl apply -f deployments/blue-deployment.yaml
kubectl apply -f deployments/green-deployment.yaml
kubectl apply -f deployments/service.yaml
```

### 3. Switch Traffic

```bash
./scripts/switch.sh blue   # Route to blue
./scripts/switch.sh green  # Route to green
```

### 4. Test

Get the service external IP:

```bash
kubectl get svc myapp-service
```

Test which version is live:

```bash
./scripts/test.sh <SERVICE_IP> blue
./scripts/test.sh <SERVICE_IP> green
```

### 5. Export All Manifests

```bash
./scripts/export_manifests.sh
kubectl apply -f all-manifests.yaml
```

## CI/CD

A GitHub Actions workflow is included for automated build, push, and deployment.

## Error Handling

- Scripts exit with error codes and messages on failure.
- Test script checks connectivity and response content.

---

**Replace all `mydockerhubusername` with your Docker Hub username before use.**
