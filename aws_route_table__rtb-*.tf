resource "aws_route_table" "rtb-p1" {
  propagating_vgws = []
  route            = []
  tags             = {}
  vpc_id           = aws_vpc.cluster.id
}

resource "aws_route_table" "rtb-p2" {
  propagating_vgws = []
  route            = []
  tags             = {}
  vpc_id           = aws_vpc.cluster.id
}

resource "aws_route_table" "rtb-p3" {
  propagating_vgws = []
  route            = []
  tags             = {}
  vpc_id           = aws_vpc.cluster.id
}

