terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-s3-bucket-anishghimire"
  # force_destroy = true // this to ensure bucket deletion with objects still inside it
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket.bucket
  source = "anish.jpg"
  key    = "anishpic.jpg"
}
output "bucketname" {
  value = aws_s3_bucket.bucket.bucket_domain_name
}
