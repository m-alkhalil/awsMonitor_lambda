# when writing tf project, the structure must be split in different tf files 
#provider.tf
#input.tf 
#output.tf 
#main.tf


# vpc
# ec2
# sns 
# lambda
# CloudWatch


module "vpc" {
    source = "./modules/vpc"
    vpc-cidr = "10.0.0.0/16" 
    providers = {
      aws = aws.Ohio
    }
}
module "ec2" {
  source = "./modules/ec2"
  ec2-ami = "ami-00a929b66ed6e0de6"
  ec2-key-name = "dip-key"
  subnet-ids = module.vpc.infra-public-subnets-ids
  ec2-sg-ids = [module.vpc.ssh-sg-id, module.vpc.http-sg-id]
  providers = {
      aws = aws.Ohio
    }
}
module "sns" {
  source = "./modules/sns"
  sns_topic_name = "ec2_status"
  sns_reciever_email = "venture23acc@gmail.com"
  providers = {
      aws = aws.Ohio
    }
}
module "lambda" {
  source = "./modules/lambda"
  py_runtime = "Python3.12"
  SNS_TOPIC_ARN = module.sns.arn_sns_topic
  providers = {
      aws = aws.Ohio
    }
}
module "event_bridge" {
  source = "./modules/event_bridge"
  ec2_event_rule_name = "ec2_event_rule"
  lambda_func_name = module.lambda.out_lambda_func_name
  lambda_function_arn = module.lambda.out_lambda_func_arn
  sns_topic_arn = module.sns.arn_sns_topic
  providers = {
      aws = aws.Ohio
    }
}