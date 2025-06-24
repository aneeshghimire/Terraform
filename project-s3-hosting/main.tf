terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my-webhosting-bucket" {
  bucket = "anish-terraform-s3-hosting-bucket"
}

resource "aws_s3_object" "errorpage" {
  bucket       = aws_s3_bucket.my-webhosting-bucket.bucket
  source       = "./error.html"
  key          = "error.html"
  content_type = "text/html"
}
resource "aws_s3_object" "indexpage" {
  bucket       = aws_s3_bucket.my-webhosting-bucket.bucket
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_public_access_block" "mywebpage" {
  bucket                  = aws_s3_bucket.my-webhosting-bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.my-webhosting-bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.my-webhosting-bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "name" {
  bucket = aws_s3_bucket.my-webhosting-bucket.id
  index_document {
    suffix = "index.html"
  }
}


output "website_link" {
  value = "http://${aws_s3_bucket.my-webhosting-bucket.website_endpoint}"
}
