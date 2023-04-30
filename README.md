# GKE Multi-Container Orchestration

### Introduction

This project demonstrates the process of deploying a multi-container Fibonacci index calculator application using Google Kubernetes Engine (GKE) for container orchestration, Jenkins for CI/CD, and Docker for containerization. The application follows a microservices architecture, with each component containerized using Docker. The Fibonacci index calculator was chosen for its simplicity, allowing the project to focus on showcasing the effective implementation of this architecture and the CI/CD process.

### Prerequisites

1. **Google Cloud Platform (GCP) account** 

2. **GKE Cluster:** Create a GKE cluster in the GCP console

3. **Docker**

4. **Jenkins Server** Ensure that the Google Kubernetes Engine plugin is installed and configured, and all the secrets and credentials are configured.

5. **kubectl** 

6. **Docker Hub account** 


### Final Output

The final output of this project is a running multi-container application orchestrated by GKE, featuring automated building, testing, and deployment using Jenkins.

![Screenshot 2023-04-30 at 10 38 37](https://user-images.githubusercontent.com/117165801/235341588-51ae2209-554b-418f-a5d3-0a5eef19c5f7.png)

Users can access the app by visiting the external IP address of the Ingress service.

 
 ## Application Architecture
 
![Screenshot 2023-04-29 at 19 19 39](https://user-images.githubusercontent.com/117165801/235312886-695a75c0-88f0-4d29-9146-02194375697e.png)



#### The Fibonacci index calculator is a multi-container application with a microservices architecture, composed of the following components:

**Frontend(client):** A React application that serves as the user interface for the calculator. Users can enter the desired Fibonacci index and receive the corresponding Fibonacci number in response.

**Worker:** A Node.js component that calculates Fibonacci numbers, listens for new index requests from Redis, and stores the results back in Redis.

**Redis:** An in-memory data store used for caching the Fibonacci number results to improve performance and reduce the load on the backend.

**PostgreSQL:** A relational database used to store the calculation history for each Fibonacci index requested by the users.

*The application is containerized using Docker, with separate images for the frontend, backend, Redis, and PostgreSQL components.*


**Ingress-NGINX** is used for routing and load balancing, managing incoming requests to the appropriate application components:
 
![Screenshot 2023-04-29 at 18 45 09](https://user-images.githubusercontent.com/117165801/235311356-292e71af-8208-45d3-9dbd-e18d5562f9eb.png)


 ## Deployment Process
 
 
1. Developers push code changes to the repository.
2. Jenkins detects the changes and triggers a build based on the Jenkinsfile configuration.
3. Jenkins executes the "Configure SDK with account auth info" stage, which authenticates with Google Cloud Platform (GCP) and configures the GKE cluster (that was created in advance in GKE UI), and other necessary components.
4. Jenkins moves on to the "Login to Docker CLI" stage, where it logs into Docker Hub with the provided credentials.
5. The "Build and test multi-client image" stage builds the Docker images for the client, server, and worker components and runs tests for the client.
6. Jenkins proceeds to the "Deploy New Images and Apply Configs" stage, which runs the deploy.sh script to push the Docker images to Docker Hub, and then applies the Kubernetes configurations using kubectl to deploy the application on GKE.
7. The multi-container application is now accessible to users via the Ingress service in the GKE cluster, which routes incoming traffic to the client and server components based on the specified paths.
Users can access the application by visiting the external IP address of the Ingress service.

![Screenshot 2023-04-30 at 11 09 59](https://user-images.githubusercontent.com/117165801/235342794-18407624-620f-4cb1-b5e8-26bb2526a2bb.png)



### Conclusion

This project demonstrates the deployment of a multi-container application using Google Kubernetes Engine, Jenkins, and Docker. By following a microservices architecture, the application effectively separates concerns, allowing for easier scaling and maintenance. The utilization of GKE for container orchestration and Jenkins for CI/CD ensures a seamless and efficient process, from pushing code changes to providing a fully functional application accessible by users.



