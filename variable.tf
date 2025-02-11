variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    default = "10.0.1.0/24"
  
}
variable "route_table_cidr"{
  default = "0.0.0.0/0"
}
 
variable "key_name" {
  default = "sonar_key"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "ami" {
  default = "ami-04b4f1a9cf54c11d0"
}
variable "thinkpad_ip" {
  type = list(string)
  default = ["103.133.230.45/32", "152.57.92.229/32"]
  
}

