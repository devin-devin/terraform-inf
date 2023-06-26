# Infrastructure Setup with Terraform

This repository contains Terraform code to set up the following infrastructure components on AWS:

## Components

- VPC with Internet Gateway
- Public Subnets
- Private Subnets
- NAT Gateways for Internet access in Private Subnets
- Fargate Tasks
- Amazon Aurora RDS instances with Read Replicas
- Application Load Balancer (ALB) to distribute traffic to Fargate Tasks
- Client VPC Endpoint
- Amazon EFS for Fargate Tasks to access

## Prerequisites

- Terraform installed (version >= 0.14)
- AWS credentials configured

## Usage

1. Clone the repository:

git clone <repository_url>
cd <repository_directory>


2. Initialize the Terraform project:

terraform init

3. Review and modify the `variables.tf` file to customize the configuration if needed.

4. Deploy the infrastructure:

terraform apply 


5. After the deployment is complete, you will see the outputs with relevant information like VPC ID, Subnet IDs, RDS endpoint, etc.

6. To destroy the infrastructure when no longer needed:


terraform destroy


**Note:** The destroy command will remove all the created resources. Make sure to back up any important data before running this command.

## Customization

- Modify the variables in the `variables.tf` file to customize aspects like VPC CIDR block, subnet configurations, RDS settings, etc.
- Adjust security group rules to fit your specific requirements.




