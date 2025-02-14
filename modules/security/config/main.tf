resource "aws_config_configuration_recorder" "recorder" {
  name     = "config-recorder"
  role_arn = aws_iam_role.config_role.arn
}

resource "aws_config_delivery_channel" "delivery" {
  name           = "config-delivery-channel"
  s3_bucket_name = aws_s3_bucket.config_logs.bucket
}

resource "aws_config_configuration_recorder_status" "recorder_status" {
  name       = aws_config_configuration_recorder.recorder.name
  is_enabled = true
}

# Security Rule 1: Ensure only approved AMIs are used
resource "aws_config_config_rule" "approved_amis" {
  name = "approved-amis"

  source {
    owner             = "AWS"
    source_identifier = "APPROVED_AMIS_BY_ID"
  }

  scope {
    compliance_resource_types = ["AWS::EC2::Instance"]
  }

  input_parameters = <<PARAMS
  {
    "amiIds": ["ami-12345678", "ami-87654321"] # Update with your allowed AMIs
  }
  PARAMS
}

# Security Rule 2: Ensure SSH is not open to public
resource "aws_config_config_rule" "restricted_ssh" {
  name = "restricted-ssh"

  source {
    owner             = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }

  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }
}
