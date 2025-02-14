variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Map of public subnets"
  type        = map(string)
}

variable "private_subnet_cidrs" {
  description = "Map of private subnets"
  type        = map(string)
}

variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
}
