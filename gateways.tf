# Internet Gateway
resource "aws_internet_gateway" "kito_gw" {
  vpc_id = aws_vpc.kito_main.id
}
