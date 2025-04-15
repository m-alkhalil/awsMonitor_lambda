import boto3
import json
import os
import logging



def lambda_handler(event, context):
    
    handler_logger = logging.getLogger()
    handler_logger.setLevel(logging.DEBUG)
    print("🔍 Event received by Lambda:")
    print(json.dumps(event, indent=2))

    sns = boto3.client("sns")
    ec2 = boto3.client("ec2")

    SNS_TOPIC_ARN = os.environ.get("SNS_TOPIC_ARN")
    if not SNS_TOPIC_ARN:
        raise Exception("SNS_TOPIC_ARN environment variable is not set")

    instance_id = event.get('detail', {}).get('instance-id')
    if not instance_id:
        raise Exception("Instance ID not found in the event payload")

    try:
        response = ec2.start_instances(InstanceIds=[instance_id])
        handler_logger.info(f"Starting instance: {instance_id} ...")
        email_msg =( f"EC2 Instance ID: {instance_id}\n"
                     f"Action: Restart triggered by Lambda\n"
                     f"Status: SUCCESS"
        )
        sns_response = sns.publish(
            TopicArn = SNS_TOPIC_ARN,
            Message = email_msg,
            Subject = f"EC2 instance:{instance_id} autostart successful"
        )
        handler_logger.info(f"SNS response: {sns_response}")
        return {
            'statusCode': 200, 
            'body': json.dumps(f'Started Instance {instance_id} ... Notification sent!')
        }
    except Exception as e:
        handler_logger.error(f"Starting Instance Error: {str(e)}")
        email_msg =( f"EC2 Instance ID: {instance_id}\n"
                     f"Action: Restart triggered by Lambda\n"
                     f"Status: FAILD"
        )
        sns_response = sns.publish(
            TopicArn = SNS_TOPIC_ARN,
            Message = email_msg,
            Subject = f"ERROR: unable to autostart EC2 instance:{instance_id}..."
        )
        handler_logger.error(f"SNS response: {sns_response}")
        return {
            'statusCode': 500,
            'body': json.dumps('Error Starting Instance...Notification sent!')
        }
    

 ## for testing locally   
# if __name__ == "__main__":
#     test_event = {
#         "detail": {
#             "instance-id": "i-00544787ec36918d5",
#             "state": "stopped"
#         }
#     }
#     lambda_handler (test_event, None)