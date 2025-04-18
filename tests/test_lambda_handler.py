import pytest
from unittest.mock import patch, M # help simulate an objects, ex boto3.clinet
from main_lambda import lambda_handler
import json
import boto3
import os



# Use pytest to run tests and organize setup with fixtures
# Use unittest.mock (or pytest-mock plugin) to fake out AWS services

#this will mock the boto api calls and act as if they happened.
#it will check if the code would call them correctly, but no real aws calls

# Lambda function uses boto3.client("ec2") and boto3.client("sns").
# We don’t want the test to actually talk to AWS. So instead, we’ll mock these clients to:
#     Pretend like they exist.
#     Let us control what they return.
#     Check if they were called correctly.
@patch("boto3.client")
def test_lambda(mock_boto):
    #Using unittest.mock, we’ll replace boto3.client 
    #with a fake object that we can inspect and control.

#this will create an event, it will be reusable 
@pytest.fixture
def simple_event():
    return {
        'detail': {
            "instance-id": ""
        }
    }


def test_lambda_handler(simple_event):

    ...