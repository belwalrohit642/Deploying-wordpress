# Deploying-wordpress on AWS with RDS using terraform and Docker
This project aims to deploy a WordPress website using Terraform for infrastructure provisioning, Docker for containerization, and AWS services for hosting. The steps involved in setting up the project are outlined below.

# Terraform Configuration
Start by creating a Terraform script (main.tf) to provision the necessary infrastructure on AWS. The script creates a VPC, public and private subnets, and an EC2 instance in the public subnet. The EC2 instance will host the WordPress container.

Use the terraform apply command to execute the Terraform script and create the infrastructure on AWS.

# Docker Image Creation
Create a Dockerfile to build a custom Docker image. The Dockerfile specifies the base image as php:7.4-apache and installs necessary dependencies like PHP, Apache, and required PHP extensions.

Include the WordPress installation steps within the Dockerfile. Download the WordPress package, extract it to the container, and configure any custom settings required.

Build the Docker image using the docker build command and tag it with a name. 

--> docker build -t belwalrohit642/php-image:v2 .

Push the Docker image to Docker Hub or any other container registry using the docker push command. Ensure you have proper credentials and permissions to access the container registry.
 
--> docker push belwalrohit642/php-image:v2

# Deploying the Docker Container
Launch an EC2 instance in the public subnet created earlier using Terraform. This instance will be used to run the WordPress container.

SSH into the EC2 instance and pull the Docker image from Docker Hub using the docker pull command. Retrieve the image you pushed in the previous step.

-->docker pull belwalrohit642/php-image:tagname

Run the Docker container on the EC2 instance using the docker run command, specifying the necessary configuration options such as port mappings and environment variables. Ensure the container is running and accessible.

--> docker run -d -p 32768:80 belwalrohit642/php-image:v2

# Configuring AWS RDS
Manually create an AWS RDS (Relational Database Service) instance in a private subnet within the same VPC created earlier. This RDS instance will be used as the database for the WordPress website.

Configure the RDS instance by specifying the database engine, credentials, storage, and any other necessary settings.

Ensure that the security group associated with the RDS instance allows incoming connections from the EC2 instance where the WordPress container is running.
# Then connect the Wordpress container with the RDS database
Upon completion, the WordPress website will be accessible through the public IP or DNS of the EC2 instance, with the website's content and data stored in the RDS database.

