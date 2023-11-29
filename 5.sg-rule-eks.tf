resource "aws_security_group_rule" "bastion-self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.bastion_sg.id
}
resource "aws_security_group_rule" "eks-bastion" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.allnodes-sg.id
  security_group_id        = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "bastion-eks" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.bastion_sg.id
  security_group_id        = aws_security_group.allnodes-sg.id
}
resource "aws_security_group_rule" "eks-web" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.allnodes-sg.id
  cidr_blocks       = [aws_vpc.cluster.cidr_block]
}

resource "aws_security_group_rule" "eks-all-443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [aws_vpc.cluster.cidr_block]
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
  cidr_blocks       = [aws_vpc.cluster.cidr_block]
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
resource "aws_security_group_rule" "eks-all-node" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.allnodes-sg.id
  security_group_id        = aws_security_group.cluster-sg.id
}

resource "aws_security_group_rule" "eks-node-all" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.cluster-sg.id
  security_group_id        = aws_security_group.allnodes-sg.id
}

resource "aws_security_group_rule" "eks-all-self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.cluster-sg.id
}

resource "aws_security_group_rule" "eks-node-self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.allnodes-sg.id
}
