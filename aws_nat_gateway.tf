# Tạo Internet Gateway
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.cluster.id
}

resource "aws_nat_gateway" "nat-i1" {
  allocation_id = aws_eip.my-eip[0].id
  subnet_id     = aws_subnet.subnet-i1.id
}

resource "aws_nat_gateway" "nat-i2" {
  allocation_id = aws_eip.my-eip[1].id
  subnet_id     = aws_subnet.subnet-i2.id
}

resource "aws_nat_gateway" "nat-i3" {
  allocation_id = aws_eip.my-eip[2].id
  subnet_id     = aws_subnet.subnet-i3.id
}