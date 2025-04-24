resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "sns_email_subsc" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol = "email"
  endpoint = var.sns_receiver_email
}

# now update cloud watch rule:
#   create cloud watch rule event for sns
#   create an IAM role that CloudWatch Events can assume 
#        to publish events to the SNS topic
#   CloudWatch Event Target:  set up the event rule to specify the SNS 
#        topic (or any other target) as the destination for the events.