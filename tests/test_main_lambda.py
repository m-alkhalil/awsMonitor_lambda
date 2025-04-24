import pytest
from unittest.mock import MagicMock, patch
from src.main_lambda import lambda_handler
import json
import boto3
import os


@pytest.fixture
def mock_ec2():
    ec2 = MagicMock()
    ec2.start_instances.return_value = {"StartingInstances": [{"InstanceID": "i-93673903652"}]}
    return ec2

@pytest.fixture
def mock_sns():
    sns = MagicMock()
    sns.publish.return_value = {"MessageId": "test-msg-if"}
    return sns

@pytest.fixture
def test_event():
    return {
        "detail": {
            "instance-id": "i-93673903652"
        }
    }


@pytest.fixture(autouse = True)
def mock_env_vars(monkeypatch):
    monkeypatch.setenv("SNS_TOPIC_ARN","arn:aws:sns:us-east-1:123456789012:my-topic")

def test_lambda_success(test_event, mock_ec2,mock_sns):

    with patch("boto3.client") as mock_boto_client:
        mock_boto_client.side_effect = lambda service: mock_ec2 if service == "ec2" else mock_sns

        response = lambda_handler(test_event, None)

        assert response["statusCode"]==200
        assert "Started Instance" in response["body"]
        mock_ec2.start_instances.assert_called_once_with(InstanceIds=["i-93673903652"])
        mock_sns.publish.assert_called_once()
        
def test_sns_publish_failure(test_event, mock_ec2):
    
    with patch("boto3.client") as mock_boto3_client:
        #redefine to override the original behavior 
        mock_ec2= MagicMock()
        mock_sns = MagicMock()
        mock_boto3_client.side_effect = lambda service: mock_ec2 if service == "ec2" else mock_sns

        mock_sns.publish.side_effect = Exception("SNS Publish failed")
        response = lambda_handler(test_event, None)

        assert response["statusCode"] == 207
        assert "notification failed" in json.loads(response["body"]).lower()
        mock_ec2.start_instances.assert_called_once()

def test_ec2_fail_sns_success():
    with patch("boto3.client")as mock_boto3_client:
        mock_ec2 = MagicMock()
        mock_sns = MagicMock()

        mock_ec2.start_instances.side_effect = Exception("autostart has failed")
        mock_sns.publish.side_effect = Exception("notification failed")

def test_sc2_autostart_failure(test_event, mock_sns):
    with patch("boto3.client") as mock_boto3_client:
        mock_ec2 = MagicMock()

        mock_boto3_client.side_effect = lambda service: mock_ec2 if service == "ec2" else mock_sns

        mock_ec2.start_instances.side_effect = Exception("EC2 instance autostart failed..")

        response = lambda_handler(test_event, None)
        assert response["statusCode"] == 500
        assert "autostart has failed " in json.loads(response["body"])
        mock_sns.publish.assert_called_once()


def test_bad_event():

    with patch ("boto3.client") as mock_boto3_client:
        mock_ec2 = MagicMock()
        mock_sns = MagicMock()
        mock_boto3_client.side_effect = lambda service : mock_ec2 if service =="ec2" else mock_sns

        bad_event = {
            "detail" : {

            }
        }

        with pytest.raises(Exception, match="Instance ID not found in the event payload"):
            lambda_handler(bad_event, None)
