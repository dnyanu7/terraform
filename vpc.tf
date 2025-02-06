# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = var.vpc_cidr

tags = {
    terraform = "true"
    Name = "sonar-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.example.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "sonar-public-Subnet"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block =var.route_table_cidr
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "sonar_Route_table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.example.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "sonar_internet_gatewway"
  }
}