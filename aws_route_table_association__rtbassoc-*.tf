resource "aws_route_table_association" "rtbassoc-p1" {
  route_table_id = aws_route_table.rtb-0102c621469c344cd.id
  subnet_id      = aws_subnet.subnet-p1.id
}

resource "aws_route_table_association" "rtbassoc-p2" {
  route_table_id = aws_route_table.rtb-0329e787bbafcb2c4.id
  subnet_id      = aws_subnet.subnet-p2.id
}


resource "aws_route_table_association" "rtbassoc-p3" {
  route_table_id = aws_route_table.rtb-041267f0474c24068.id
  subnet_id      = aws_subnet.subnet-p3.id
}


resource "aws_route" "routeTable-i1" {
  route_table_id         = aws_route_table.routeTable-i1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-i1.id
}

resource "aws_route" "routeTable-i2" {
  route_table_id         = aws_route_table.routeTable-i2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-i2.id
}

resource "aws_route" "routeTable-i3" {
  route_table_id         = aws_route_table.routeTable-i3.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-i3.id
}

resource "aws_route_table_association" "rtbassoc-i1" {
  route_table_id = aws_route_table.routeTable-i1.id
  subnet_id      = aws_subnet.subnet-i1.id
}

resource "aws_route_table_association" "rtbassoc-i2" {
  route_table_id = aws_route_table.routeTable-i2.id
  subnet_id      = aws_subnet.subnet-i2.id
}


resource "aws_route_table_association" "rtbassoc-i3" {
  route_table_id = aws_route_table.routeTable-i3.id
  subnet_id      = aws_subnet.subnet-i3.id
}