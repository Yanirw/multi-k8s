# GKE Multi-Container Orchestration

### Introduction

This project demonstrates the process of deploying a multi-container Fibonacci index calculator application using Google Kubernetes Engine (GKE), Jenkins, and Docker. The application follows a microservices architecture, with each component containerized using Docker.

Google Kubernetes Engine (GKE) is leveraged for container orchestration, managing the deployment, scaling, and maintenance of the application components. Jenkins is used for CI/CD, ensuring seamless building, testing, and deployment of the application.

The application is intentionally kept simple, as the primary focus is not on complex functionality, but rather on showcasing the application's architecture and the CI/CD process.

### Final Output

The final output of this project is a running multi-container application orchestrated by GKE, featuring automated building, testing, and deployment using Jenkins.

 Users can access the app by visiting the external IP address of the Ingress service.
 
 ## Deployment Process
 
1. Developers push code changes to the repository.
2. Jenkins detects the changes and triggers a build based on the Jenkinsfile configuration.
3. Jenkins executes the "Configure SDK with account auth info" stage, which authenticates with Google Cloud Platform (GCP) and configures the GKE cluster and other necessary components.
4. Jenkins moves on to the "Login to Docker CLI" stage, where it logs into Docker Hub with the provided credentials.
5. The "Build and test multi-client image" stage builds the Docker images for the client, server, and worker components and runs tests for the client.
6. Jenkins proceeds to the "Deploy New Images and Apply Configs" stage, which runs the deploy.sh script to push the Docker images to Docker Hub, and then applies the Kubernetes configurations using kubectl to deploy the application on GKE.
7. The multi-container application is now accessible to users via the Ingress service in the GKE cluster, which routes incoming traffic to the client and server components based on the specified paths.
Users can access the application by visiting the external IP address of the Ingress service.

## Application Architecture

![Screenshot 2023-04-29 at 1 22 11](https://user-images.githubusercontent.com/117165801/235263615-57d471d6-d218-409b-88e5-b2b396f96058.png)

#### The Fibonacci index calculator is a multi-container application with a microservices architecture, composed of the following components:

**Frontend(client):** A React application that serves as the user interface for the calculator. Users can enter the desired Fibonacci index and receive the corresponding Fibonacci number in response.

**Worker:** A Node.js component that calculates Fibonacci numbers, listens for new index requests from Redis, and stores the results back in Redis.

**Redis:** An in-memory data store used for caching the Fibonacci number results to improve performance and reduce the load on the backend.

**PostgreSQL:** A relational database used to store the calculation history for each Fibonacci index requested by the users.

*The application is containerized using Docker, with separate images for the frontend, backend, Redis, and PostgreSQL components.*
