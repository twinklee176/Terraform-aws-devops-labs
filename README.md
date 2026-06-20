# Terraform-aws-devops-labs
Terraform AWS DevOps Hands-on Labs

##Tasks Overview
Task 1: EC2 Instance with Public IP

Provisioned an EC2 instance using Terraform with a public IP address enabled.

Key focus:

Basic EC2 provisioning
AWS provider configuration

##Task 2: EC2 Instance with Private IP

Provisioned an EC2 instance without a public IP for restricted network access.

Key focus:

Private networking in AWS
Secure instance deployment
##Task 3: S3 → SQS → Lambda Pipeline

Implemented an event-driven architecture using AWS services:

S3 bucket triggers events on object upload
Events are sent to SQS queue
Lambda function processes messages and extracts:
Bucket name
Object key

Key focus:

Serverless architecture
Event-driven processing

##Task 4: Terraform Variables

Demonstrates the usage of different Terraform variable types:

string
list
map
object
set

Includes:

terraform.tfvars for input configuration
Output values for structured results

Key focus:

Reusable Infrastructure as Code design
Variable management in Terraform
Tools & Technologies
Terraform
AWS (EC2, S3, SQS, Lambda, IAM)
Git & GitHub


#Repository Structure

Terraform-AWS-Labs/
│
├── README.md
│
├── Task-1-EC2-Public-IP/
│   ├── main.tf
│   └── README.md
│
├── Task-2-EC2-Private-IP/
│   ├── main.tf
│   └── README.md
│
├── Task-3-S3-SQS-Lambda-Pipeline/
│   ├── main.tf
│   ├── lambda.py
│   └── README.md
│
└── Task-4-Terraform-Variables/
    ├── main.tf
    ├── variables.tf
    ├── terraform.tfvars
    ├── output.tf
    └── README.md
