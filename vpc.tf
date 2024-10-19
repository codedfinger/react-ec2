# VPC
resource "aws_vpc" "kito_main" {
  cidr_block = "10.0.0.0/23" # 512 IPs 
  tags = {
    Name = "kito-vpc"
  }
}

# Creating 1st subnet 
resource "aws_subnet" "kito_subnet_1" {
  vpc_id                  = aws_vpc.kito_main.id
  cidr_block              = "10.0.0.0/27" #32 IPs
  map_public_ip_on_launch = true          # public subnet
  availability_zone       = "us-east-1a"
}

# Creating 2nd subnet in AZ us-east-1b
resource "aws_subnet" "kito_subnet_2" {
  vpc_id                  = aws_vpc.kito_main.id
  cidr_block              = "10.0.0.32/27" # Another 32 IPs
  map_public_ip_on_launch = true          # public subnet
  availability_zone       = "us-east-1b"
}
