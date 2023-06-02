# Provider configuration (replace with your desired provider details)
provider "aws" {
  region = "us-east-1"
}

# VPC creation
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Internet Gateway creation
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Route table creation for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

# Associating the route table with the internet gateway
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Public subnet creation
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

# Private subnet creation
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
}

# Route table creation for private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

# Associating the route table with the private subnet
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# Public EC2 instance creation
resource "aws_instance" "public_instance" {
  ami           = "ami-053b0d53c279acc90" # Replace with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  associate_public_ip_address = true
  key_name      = "terraform_ec2" # Replace with your key pair name

  tags = {
    Name = "public-instance"
  }
}

