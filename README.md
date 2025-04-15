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
    Terraform (remote state with S3 + DynamoDB locking)
    AWS Lambda (Python 3.x)
    AWS EC2
    CloudWatch Events (EventBridge)
    SNS
    IAM
## Project Structure/ tree
## Running the code
```
py 
```
## Test 

# Contact / Feedback
Feel free to open issues or reach out via LinkedIn [Mahran Alkhalil](linkedin) if you have feedback!

