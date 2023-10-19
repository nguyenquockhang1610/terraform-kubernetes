resource "aws_security_group_rule" "eks-all" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.cluster.cidr_block]  # Sử dụng [ ] để đặt giá trị trong một danh sách
  security_group_id = aws_security_group.cluster-sg.id
}

resource "aws_security_group_rule" "eks-all-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.cluster-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "eks-node" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.cluster.cidr_block]  # Sử dụng [ ] để đặt giá trị trong một danh sách
  security_group_id = aws_security_group.allnodes-sg.id
}

resource "aws_security_group_rule" "eks-node-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.allnodes-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
