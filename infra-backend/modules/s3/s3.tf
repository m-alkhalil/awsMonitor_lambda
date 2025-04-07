resource "aws_s3_bucket" "s3-state-locking-bucket"{
    # provider = "aws.Ohio"
    bucket = var.s3-lock-bucket-name
    object_lock_enabled = true
    tags = {
        Name = var.s3-lock-bucket-name
    }
        
}

#***** TO BE IMPLEMENTED IN FUTURE*******
# implement the lock object mode to restrict access to the s3 object. this will lock the
# whole s3 object, it is a separate feature from state file lock which prevent 
# # concurent acces to the state file
# resource "aws_s3_bucket_object_lock_configuration" "s3locking-configuration" {
#   bucket = aws_s3_bucket.s3-state-locking-bucket
#   rule {
#     default_retention {
#       mode = "GOVERNANCE"
#       days = 365
#     }
#   }
# }

# resource "aws_s3_bucket_policy" "s3-object-locking-policy" {
  
# }
