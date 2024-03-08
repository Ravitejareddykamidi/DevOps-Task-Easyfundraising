Containerized Application Deployment and Infrastructure Orchestration
Introduction
This README provides an overview of the tasks completed in the containerized application deployment and infrastructure orchestration project. The goal was to streamline the deployment process of a sample application, enhance its production readiness, and automate the deployment pipeline.

1: Git Branching and Merging Strategy
In the Git branching and merging strategy, we followed a structured approach to code development. For each task, a dedicated feature branch was created, allowing for isolated development. The "feature" branches were utilized for implementing changes, and a CI/CD pipeline (ci.yml) ensured automatic deployments upon successful pushes. Once feature development and testing were completed, changes were merged into the "develop" branch. The final step involved merging into the "main" branch, signifying the completion of the task.

2: Docker Image and Container Registry
In the Docker image and container registry phase, a Flask application displaying the current date and time was developed. This application was containerized using a Dockerfile, resulting in a Docker image tagged as v1.0. Continuous integration and deployment (CI/CD) actions were implemented through the ci.yml file, automating image builds. The Docker image was published to a selected container registry.

![image](https://github.com/Ravitejareddykamidi/DevOps-Task-Easyfundraising/assets/51575336/1926d2e8-3c1d-4794-939a-c7252c4a8961)


3: Helm Chart and Helm Repository
For Helm chart and repository management, the sample application was packaged as a Helm chart. An S3 bucket served as the designated Helm repository, providing an organized structure for storing charts. The Helm CLI was utilized to create, package, and push the Helm chart into the S3 repository. Furthermore, an index.yaml file was meticulously generated for the Helm chart repository.

![image](https://github.com/Ravitejareddykamidi/DevOps-Task-Easyfundraising/assets/51575336/e0198dfa-cd9f-4cf3-a990-b94abf48a0ce)


4: Infrastructure Provisioning with Terraform
In the Terraform and infrastructure provisioning phase, Terraform scripts were crafted to provision infrastructure for deploying the sample app. State files were stored in an S3 bucket, and a DynamoDB locking system was implemented to prevent concurrent executions.

![image](https://github.com/Ravitejareddykamidi/DevOps-Task-Easyfundraising/assets/51575336/70117fbc-bf2f-4f17-ae09-6556f4a5d806)


5: ArgoCD Deployment for Auto-Deployment
This section highlights the deployment of ArgoCD on an EKS cluster, automating the deployment process. The ArgoCD image updater was integrated to automatically update the Docker image upon new versions in the Amazon ECR registry.

Steps
ArgoCD Installation:

Deployed ArgoCD to the EKS cluster using kubectl apply with the provided manifests.

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.7/manifests/install.yaml

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

export ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

argocd login $ARGOCD_SERVER --username admin --password $ARGO_PWD --insecure

ArgoCD Image Updater:

Installed the ArgoCD image updater to automatically update the Docker image when changes are pushed to the ECR registry.
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml

ArgoCD Application Deployment:

Configured ArgoCD to deploy the sample application using a Helm chart stored in the S3 bucket.

![image](https://github.com/Ravitejareddykamidi/DevOps-Task-Easyfundraising/assets/51575336/ff1f593f-c5a2-46f9-8941-37753c119f23)

![image](https://github.com/Ravitejareddykamidi/DevOps-Task-Easyfundraising/assets/51575336/7e9d3b74-9e6d-4315-a143-b84d249fa4a1)

6: Ensuring Production-Ready Application
To ensure the sample application's production readiness, essential features were implemented. Readiness and liveness probes were integrated for robust application health monitoring. Horizontal Pod Autoscaler (HPA) was configured for dynamic replica adjustment based on resource utilization. Resource limits for CPU and memory were set to optimize resource utilization.

7: Exposing the Application
The deployed application was exposed using a LoadBalancer service type on port 5000. This allows external access to the application, as demonstrated in the image below.

![image](https://github.com/Ravitejareddykamidi/DevOps-Task-Easyfundraising/assets/51575336/867ae709-51d9-4b76-8cba-7ac550417e69)

This setup ensures that ArgoCD continuously monitors changes in the Helm chart stored in the S3 bucket, automatically updating the deployed application whenever a new Docker image version is pushed to the ECR registry. The LoadBalancer service exposes the application externally, allowing easy access and verification of the deployment.


Task 2: Terraform Modules for Repeated Provisioning

1.MySQL 8.x RDS Instance Provisioning:

Implemented Terraform modules to spin up MySQL 8.x RDS instances with specific configurations for different environments:
Development:
Instance size: Free tier
Multi-AZ: No
Encryption keys: No CMK
Staging:
Instance size: Bare Minimum
Multi-AZ: Yes
Encryption keys: CMK

![image](https://github.com/Ravitejareddykamidi/DevOps-Task-Easyfundraising/assets/51575336/833af761-6a28-464d-8b25-7fcabc0cd2c4)


![image](https://github.com/Ravitejareddykamidi/DevOps-Task-Easyfundraising/assets/51575336/52fe1c87-589f-4793-a6fd-7f173ebb5bcd)

2.User Management:

Dynamically created RDS users from a user-defined array.
Granted ALL privileges to the created users.

![image](https://github.com/Ravitejareddykamidi/DevOps-Task-Easyfundraising/assets/51575336/df20cc46-5bcf-40f3-9f9d-45b7f679cb85)

3.Multi-tier Architecture Design:

Deployed an EC2 instance to facilitate secure access to the RDS instance within the multi-tier architecture.

![image](https://github.com/Ravitejareddykamidi/DevOps-Task-Easyfundraising/assets/51575336/88f7f3be-8235-460a-bf30-bb156d74b2b3)

![image](https://github.com/Ravitejareddykamidi/DevOps-Task-Easyfundraising/assets/51575336/038b27a2-24f7-4c5a-8e9d-aca77b1a2629)





