module "s3" {
  source = "./modules/s3"
  s3-lock-bucket-name = "awsmonitor-infra-s3-backend"
}