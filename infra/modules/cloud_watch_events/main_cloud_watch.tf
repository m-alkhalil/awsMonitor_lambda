#event-bridge is the new name for cloud watch events, came with added features
#1. create event bridge rule
#2. create the event target
#3. add permessions to the event to invoke lambda

#work flow:
# EC2 sends "stopped" event >
# CloudWatch Event Rule (filter for stopped state) >
# CloudWatch Event Target (sends to Lambda) >
# Lambda Permission (allows EventBridge to call Lambda) >
# Lambda function gets triggered 


resource "aws_cloudwatch_event_rule" "cw_ec2-stopped_rule" {
  name = var.event_rule_name
  description = "this rule triggers lambda function when an ec2 instance is stopped"
    
    #even filter/pattern
  event_pattern = jsondecode({
    source = ["aws.ec2"], 
    "detail-type" = ["EC2 Instance State-change Notification"]
    detail={
        state = "Stopped"
    }
  })
}

resource "aws_cloudwatch_event_target" "cw_target_lambda" {
    arn = var.lambda_function_arn 
        #function to invoke
    rule = aws_cloudwatch_event_rule.cw_ec2-stopped_rule.name
        # like to cw  rule 
    target_id = "lambda_ec2_trigger" 
        #can be any name
  
}

resource "aws_lambda_permission" "lambda_evbr_permt" {
  statement_id = "AllowExecutionFromEventBridge"
    #just an identifier
  action = "lambda:InvokeFunction"
    #what action cw is going to take
  function_name = var.lambda_func_name
    #lambda function name
  principal = "events.amazonaws.com"
    #tells lambda i'm allowing event bridge to take action
  source_arn = aws_cloudwatch_event_rule.cw_ec2-stopped_rule.arn
    #We restrict this permission to only the event rule defined above

}


# ****** SETUP SNS ******

resource "aws_cloudwatch_event_rule" "cw_sns_event_rule" {
  name = "SNS-Event-Rule"
  description= "Event rule for SNS notification"
  event_pattern = jsondecode({
    detail-type = ["EC2 Instance stopped, will be started by lambda"]
  })
}
resource "aws_cloudwatch_event_target" "cw_target_sns" {
  
  rule = aws_cloudwatch_event_rule.cw_sns_event_rule.name
  target_id = "SendToSNS"
  arn = ""
}