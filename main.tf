resource "aws_s3_bucket" "my_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "my_bucket_version" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "my_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.ownership]  #depends_on this is a meta argument

  bucket = aws_s3_bucket.my_bucket.id #which bucket i want to make it private to we give reousrce type and resource name and id. 
  acl    = "private"                  #how i am refering he bucket using ID
}