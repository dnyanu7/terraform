resource "aws_security_group" "web_sg"{
  vpc_id      = aws_vpc.example.id
  tags = {
    Name = "sonar_sg"
  }
}


# resource "aws_vpc_security_group_ingress_rule" "allow_80" {
#   security_group_id = aws_security_group.web_sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
# }
resource "aws_vpc_security_group_ingress_rule" "allow_ssh"{
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.web_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_instance" "public_ec2" {
 ami = var.ami
 instance_type = var.instance_type
 subnet_id = aws_subnet.main.id
 security_groups = [aws_security_group.web_sg.id]
 key_name = var.key_name
 
  tags = {
     Name= "sonarqube"
  }
  root_block_device {
    volume_size = 20
  }
  lifecycle {
    ignore_changes = [
      security_groups
    ]
  }

 }

resource "aws_eip" "bar" {
  domain = "vpc"
  instance                  = aws_instance.public_ec2.id
  depends_on                = [aws_internet_gateway.gw]
 tags = {
     Name= "sonarqube"
  }

}

/*resource "aws_vpc_security_group_ingress_rule" "allow_sonar" {
  security_group_id = aws_security_group.web_sg.id

   
  cidr_ipv4        = var.thinkpad_ip
  from_port         = 9000
  ip_protocol       = "tcp"
  to_port           = 9000
}*/

resource "aws_vpc_security_group_ingress_rule" "allow_sonar" {
  security_group_id = aws_security_group.web_sg.id

   for_each = toset(var.thinkpad_ip)
  cidr_ipv4        = each.value
  from_port         = 9000
  ip_protocol       = "tcp"
  to_port           = 9000
  
tags = {
    Name = "${each.value}-cidr"
  }
  
}

