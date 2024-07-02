# VPC
resource "aws_vpc" "sprinter-vpc" {
  cidr_block = "10.0.0.0/16"
}

# Subnet
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.sprinter-vpc.id
  cidr_block = "10.0.1.0/24"
}

# Internet Gateway
resource "aws_internet_gateway" "sprinter-igw" {
  vpc_id = aws_vpc.sprinter-vpc.id
}

# Route Table
resource "aws_route_table" "sprinter-rt" {
  vpc_id = aws_vpc.sprinter-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sprinter-igw.id
  }
}

resource "aws_route_table_association" "sprinter-rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.sprinter-rt.id
}
