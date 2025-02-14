regiun = 
account = 

vpc_name        = "project1_dev-vpc"
vpc_cidr_block  = "10.0.0.0/16"

public_subnet_cidrs = {
  "public-1" = "10.0.1.0/24"
  "public-2" = "10.0.2.0/24"
  "public-3" = "10.0.3.0/24"
}

private_subnet_cidrs = {
  "private-1" = "10.0.4.0/24"
  "private-2" = "10.0.5.0/24"
  "private-3" = "10.0.6.0/24"
}

availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
