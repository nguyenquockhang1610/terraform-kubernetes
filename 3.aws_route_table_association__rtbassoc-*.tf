resource "aws_route_table_association" "rtbassoc-p1" {
  route_table_id = aws_route_table.rtb-p1.id
  subnet_id      = aws_subnet.subnet-p1.id
}

resource "aws_route_table_association" "rtbassoc-p2" {
  route_table_id = aws_route_table.rtb-p2.id
  subnet_id      = aws_subnet.subnet-p2.id
}


resource "aws_route_table_association" "rtbassoc-p3" {
  route_table_id = aws_route_table.rtb-p3.id
  subnet_id      = aws_subnet.subnet-p3.id
}


resource "aws_route_table_association" "rtbassoc-i1" {
  route_table_id = aws_route_table.rtb-i.id
  subnet_id      = aws_subnet.subnet-i1.id
}

resource "aws_route_table_association" "rtbassoc-i2" {
  route_table_id = aws_route_table.rtb-i.id
  subnet_id      = aws_subnet.subnet-i2.id
}

resource "aws_route_table_association" "rtbassoc-i3" {
  route_table_id = aws_route_table.rtb-i.id
  subnet_id      = aws_subnet.subnet-i3.id
}