# AWS EC2 Auto-Recovery System with Terraform & Lambda
###     Serverless Monitoring with AWS Lambda: Event-driven Archeticture 

## Table of Contents
* [Overview](#Overview)
* [Features](#Features)
* [Tech Stack](#Tech-Stack])
* [Project Structure tree](#Project-Structure-tree)
* [Running the code](#running-the-code)
* [Contact Feedback](#contact-feedback)

## Overview
This project provisions an AWS-based infrastructure using Terraform. It includes an EC2 instance that is automatically restarted via an AWS Lambda function triggered by a CloudWatch Event. The Lambda function also notifies a user via SNS email notification. The project demonstrates infrastructure automation, serverless programming, and event-driven architecture.
## Features
    Automatic EC2 instance recovery
    Lambda function triggers on EC2 stop events
    Email alerts via SNS
    Fully IaC-driven setup using Terraform
    Environment variable integration
## Tech Stack
    Terraform (remote state with S3 + S3 locking)
    AWS Lambda (Python 3.x)
    AWS EC2
    CloudWatch Events (EventBridge)
    SNS
    IAM
## Project Structure
```
.
├── LICENSE
├── README.md
├── infra
│   ├── main.tf
│   ├── modules
│   │   ├── ec2
│   │   │   ├── main_ec2.tf
│   │   │   └── vars-ec2.tf
│   │   ├── event_bridge
│   │   │   ├── main_event_bridge.tf
│   │   │   ├── output_event_bridge.tf
│   │   │   └── vars_event_bridge.tf
│   │   ├── lambda
│   │   │   ├── main_lambda.tf
│   │   │   ├── output_lambda.tf
│   │   │   └── vars_lambda.tf
│   │   ├── sns
│   │   │   ├── main_sns.tf
│   │   │   ├── out_sns.tf
│   │   │   └── vars_sns.tf
│   │   └── vpc
│   │       ├── main_vpc.tf
│   │       ├── output_vpc.tf
│   │       └── vars_vpc.tf
│   ├── provider.tf
│   ├── terraform.tfvars
│   └── vars-main.tf
├── infra-backend
│   ├── main.tf
│   ├── modules
│   │   └── s3
│   │       ├── s3-output.tf
│   │       ├── s3-tfvars.tfvars
│   │       ├── s3-variables.tf
│   │       └── s3.tf
│   ├── provider.tf 
├── requirements.txt
├── src
│   └── main_lambda.py
├── tests
└── venv
    
```
## Running the code
### Clone the repository
```
git clone https://github.com/m-alkhalil/awsMonitor_lambda.git
```
### Configure AWS so terraform can use the configured profile:
run:
```
aws configure
```
provide: 
* AWS Access Key ID
* AWS Secret Access Key
* Default region name
* Default output formatß

#### Provestion s3 backend:

```
cd infra-backend/
terraform init
terraform plan
terraform appy
```
#### Provestion Infrastructure :

```
cd ../infra
terraform init
terraform plan
terraform appy
```
## Test 

## Contact / Feedback

Feel free to open issues or reach out via LinkedIn:

[Mahran Alkhalil](https://www.linkedin.com/in/malkhalil91)

