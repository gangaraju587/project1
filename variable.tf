variable "aws-region" {
  description = "The AWS region"
}
//variable "access_key" {}

//variable "secret_key" {}

variable "instance-type" {
  description = "The instance type to be used"
}

variable "instance-key-name" {
  description = "The name of the SSH key to associate to the instance. Note that the key must exist already."
}

variable "iam-role-name" {
  description = "The IAM role to assign to the instance"
}

variable "instance-associate-public-ip" {
  description = "Defines if the EC2 instance has a public IP address."
  default     = "false"
}

variable "instance-tag-name" {
  description = "instance-tag-name"
  //type        = "string"
  //default     = "EC2-instance-created-with-terraform"
}

variable "vpc-cidr-block" {
  description = "The CIDR block to associate to the VPC"
  //type        = "string"
}

variable "subnet-1-cidr-block" {
  description = "The CIDR block to associate to the subnet"
  //type        = "string"
}

variable "subnet-2-cidr-block" {
  description = "The CIDR block to associate to the subnet"
  //type        = "string"
}

variable "vpc-tag-name" {
  description = "The Name to apply to the VPC"
  //type        = "string"
  //default     = "VPC-created-with-terraform"
}

variable "ig-tag-name" {
  description = "The name to apply to the Internet gateway tag"
  //type        = "string"
  //default     = "aws-ig-created-with-terraform"
}

variable "subnet-tag-name" {
  description = "The Name to apply to the VPN"
  //type        = "string"
  //default     = "VPN-created-with-terraform"
}

variable "sg-tag-name" {
  description = "The Name to apply to the security group"
  //type        = "string"
  //default     = "SG-created-with-terraform"
}


variable "sg-alb-cidr_blocks" {
  description = "The Name to apply to the security group"
  //type        = "string"
}

variable "environment" {
  description = "The environment (production/staging)"
  //type        = "string"
}

variable "alb-name" {
  description = "The application Load Balancer name"
  type        = string
  //default     = "app-load-balancer-w-terraform"
}

variable "sg-alb-tag-name" {
  description = "The name of the SG associated with the ALB"
  //type        = "string"
  //default     = "SG-to-theapp-load-balancer-with-terraform"
}

variable "target-group-name" {
  description = "The name of the placement group"
  type        = string
  //default     = "lb-tg"
}

variable "launch-config-name" {
  description = "The name of the launch configuration"
  type        = string
  default     = "launch-configuration-created-with-terraform"
}

variable "asg-min-size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = string
}

variable "asg-max-size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = string
}

variable "asg-def-size" {
  description = "The default/recommended size of the Auto Scaling Group"
  type        = string
}

variable "user-data-script" {}

variable "domain-name" {
  description = "The apps public domain name"
  type        = string
}

variable "sub-domain-name" {
  description = "The apps public sub domain name"
  type        = string
}

variable "ssh-allowed-ips" {
  description = "The list of IPs that are allowed to SSH into the instances"
  type        = list(any)
}

variable "health-check-path" {
  description = "The apps public sub domain name"
  type        = string
  //default     = "/login?from=%2F"
}

variable "health-check-port" {
  description = "The apps public sub domain name"
  type        = string
  //default     = "8080"
}

variable "health_check_interval" {
  description = "The interval between health checks"
  type        = string
  default     = 5
}

variable "health_check_threshold" {
  description = "The number of consecutive health checks to be considered (un)healthy."
  type        = string
  default     = 3
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health."
  type        = string
  default     = 3
}

variable "use_https_only" {
  description = "If true, forces all http traffic to https"
  type        = string
  default     = "false"
}

variable "hostnames_staging" {
  description = "The hostnames for the staging environment"
  type        = list(any)
  default     = []
}

variable "hostnames_prod" {
  description = "The hostnames for the production environment"
  type        = list(any)
  default     = []
}
