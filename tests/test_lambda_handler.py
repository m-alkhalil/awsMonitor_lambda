import pytest
from unittest.mock import patch, M # help simulate an objects, ex boto3.clinet
from main_lambda import lambda_handler
import json
import boto3
import os

