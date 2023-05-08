resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucketdsfsdfhjkjhj"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}