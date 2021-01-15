variable "subnet1" {
  description = "default vpc subnet"
  type        = list
  default     = [ "subnet-4a770506", "subnet-34cb4f4f", "subnet-4ad3de22" ]
}

variable "sg" {
  description = "ignite sg"
  //type        = string
  default     = [ "sg-09260595668f6ddae" ]
}

variable "aws_region" {
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "public_subnets_cidr" {
  type    = list(string)
  default = ["172.16.1.0/24","172.16.2.0/24","172.16.3.0/24"]
}

variable "azs" {
  type    = list(string)
  default = ["ap-south-1c", "ap-south-1b", "ap-south-1a"]
}
