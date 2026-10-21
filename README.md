# Project-04: Three-Tier Blog Application CI/CD on Amazon EKS

## Overview

This project deploys a three-tier blog application to Amazon EKS and
automates the build, security checks, image publishing, and deployment
process with GitHub Actions.

The application has a React frontend, an Express backend API, and a
MySQL database. The pipeline also includes code quality analysis,
container image scanning, and image publishing to Amazon ECR and Nexus.

## Architecture

-   **Frontend:** React with Vite
-   **Backend:** Node.js and Express REST API
-   **Database:** MySQL 8.4
-   **Containerization:** Docker
-   **Orchestration:** Amazon EKS and Kubernetes
-   **CI/CD:** GitHub Actions
-   **Code quality:** SonarQube
-   **Image scanning:** Trivy
-   **Image registries:** Amazon ECR and Nexus Repository
-   **Monitoring:** Prometheus and Grafana

## CI/CD Workflow

The GitHub Actions workflow runs the following stages:

1.  Validate the application and build the frontend.
2.  Run backend checks and tests.
3.  Analyze code with SonarQube.
4.  Build the frontend and backend Docker images.
5.  Scan the images with Trivy.
6.  Push versioned images to Amazon ECR.
7.  Deploy the images to Amazon EKS.
8.  Check the deployment rollout and verify the Kubernetes resources.
9.  Publish images to Nexus Repository.

The latest verified workflow run completed successfully across all five
jobs.

## Kubernetes Deployment

The application runs in the `project4` namespace on the EKS cluster
`project4-eks-cluster`.

Main Kubernetes workloads and services:

-   `blog-frontend`
-   `blog-backend`
-   `mysql`
-   `blog-backend-service`
-   `mysql-service`

The backend exposes a `/metrics` endpoint for Prometheus metrics.

Useful commands to check the deployment:

``` bash
kubectl get nodes
kubectl -n project4 get deployments -o wide
kubectl -n project4 get pods -o wide
kubectl -n project4 get services
```

## Monitoring

Prometheus collects metrics from the backend, including Node.js process,
memory, event-loop, and HTTP request metrics. Grafana is connected to
Prometheus and has panels for backend availability and memory usage.

The current local monitoring setup scrapes the backend through a
Kubernetes port-forward. Start it from the project directory with:

``` bash
kubectl -n project4 port-forward service/blog-backend-service 5000:5000
```

Keep the terminal open while using this monitoring connection. If the
port-forward stops, backend metrics collection will need to be
restarted. This is a local monitoring setup and does not currently
provide automatic recovery of the port-forward.


##  Monitoring Services

The following local containers were used during the project:

-   Prometheus: port `9090`
-   Grafana: port `3000`
-   SonarQube: port `9000`
-   Nexus Repository: ports `8081` and `8082`

These services need to be running locally to access their web
interfaces.

## Repository and Evidence

Project screenshots are stored separately in the
`Project-04-Screenshots` git repo. They include evidence of the successful
GitHub Actions workflow, Prometheus target health, Grafana panels, and
the Kubernetes deployment.
