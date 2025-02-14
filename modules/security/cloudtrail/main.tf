resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket = "my-cloudtrail-logs-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_policy" "cloudtrail_logs_policy" {
  bucket = aws_s3_bucket.cloudtrail_logs.id
  policy = jsonencode({
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "cloudtrail.amazonaws.com" }
      Action   = "s3:PutObject"
      Resource = "${aws_s3_bucket.cloudtrail_logs.arn}/*"
    }]
  })
}

resource "aws_cloudtrail" "trail" {
  name           = "my-trail"
  s3_bucket_name = aws_s3_bucket.cloudtrail_logs.id
  is_multi_region_trail = true
}