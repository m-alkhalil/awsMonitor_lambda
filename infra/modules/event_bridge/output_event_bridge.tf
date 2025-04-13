output "out-arn_cw_ec2-stopped_rule" {
  value = aws_cloudwatch_event_rule.cw_ec2-stopped_rule.arn
}