variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

variable "account" {
  type        = string
  description = "AWS Account Number"
  validation {
    condition     = can(regex("\\d{12}", var.account))
    error_message = "The AWS account number is incorrect."
  }
}

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

variable "security_groups" {
  description = "Map of security groups and their rules"
  type = map(object({
    name        = string
    description = string
    rules = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), [])
      source_sg   = optional(string, null)
    }))
  }))
}