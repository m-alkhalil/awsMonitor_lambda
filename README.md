# AWS EC2 Auto-Recovery with Terraform & Lambda
###         Serverless Monitoring with AWS Lambda: Event-driven Architecture  

## Table of Contents
* [Overview](#Overview)
* [Features](#Features)
* [Tech Stack](#Tech-Stack])
* [Project Structure tree](#Project-Structure-tree)
* [Running the code](#Running-the-code)
* [Test](#Test)
* [Contact / Feedback](#contact--feedback)

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

    
```
## Running the code
### Clone the repository
```
git clone https://github.com/m-alkhalil/awsMonitor_lambda.git
```
### create py venv and install python packages
```
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
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
* Default output format

#### Provision s3 backend:
```
cd infra-backend/
terraform init
terraform plan
terraform apply
```

#### Provision Infrastructure :
add the receiver email in main.tf:
     sns_receiver_email = "name@example.com"
```
cd ../infra
terraform init
terraform plan
terraform apply
```

## Test 
Success case (when everything works as expected).

Failure cases:
* Missing environment variables.
* Missing instance ID in the event.
* EC2 start failures.
* SNS publish failures.
* Edge cases (empty or malformed events).
 
Test was written according to the following flow: 
* Write a test function using pytest
* Mock AWS services using unittest.mock
* Simulate inputs (the EventBridge payload)
* Call lambda_handler
* Assert behavior (return values, AWS calls)

### testing locally: 
add the following line after the lambda_handler function definition in main_lambda.py:
```
if __name__ == "__main__":
     test_event = {
         "detail": {
             "instance-id": "i-00544787ec36918d5",
             "state": "stopped"
         }
     }
     lambda_handler (test_event, None)
```
### unit test and pytest
* Arrange: prepare mocks and inputs, simply find out and prepare everything my function(lambda_handler) needs to work. 
* Act: make the function call.
* Assert: check if EC2 start instance was called and SNS message was sent.
### running tests
```
pytest
```

## Contact / Feedback

Feel free to open issues or reach out via LinkedIn:

[Mahran Alkhalil](https://www.linkedin.com/in/malkhalil91)

