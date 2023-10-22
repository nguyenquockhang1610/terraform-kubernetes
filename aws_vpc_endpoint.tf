resource "aws_vpc_endpoint" "vpce-autoscaling" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  private_dns_enabled = true
  route_table_ids     = []
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
    aws_security_group.cluster-sg.id
  ]
  service_name = "com.amazonaws.us-east-1.autoscaling"
  subnet_ids = [
    aws_subnet.subnet-i3.id,
    aws_subnet.subnet-i1.id,
    aws_subnet.subnet-i2.id,
  ]
  tags              = {}
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.cluster.id

  timeouts {}
}

# aws_vpc_endpoint.vpce-ec2:
resource "aws_vpc_endpoint" "vpce-ec2" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  private_dns_enabled = true
  route_table_ids     = []
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
    aws_security_group.cluster-sg.id
  ]
  service_name = "com.amazonaws.us-east-1.ec2"
  subnet_ids = [
    aws_subnet.subnet-i3.id,
    aws_subnet.subnet-i1.id,
    aws_subnet.subnet-i2.id,
  ]
  tags              = {}
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.cluster.id

  timeouts {}
}

# aws_vpc_endpoint.vpce-vpce-ec2messages:
resource "aws_vpc_endpoint" "vpce-vpce-ec2messages" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  private_dns_enabled = true
  route_table_ids     = []
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
    aws_security_group.cluster-sg.id
  ]
  service_name = "com.amazonaws.us-east-1.ec2messages"
  subnet_ids = [
    aws_subnet.subnet-i3.id,
    aws_subnet.subnet-i1.id,
    aws_subnet.subnet-i2.id,
  ]
  tags              = {}
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.cluster.id

  timeouts {}
}

# aws_vpc_endpoint.vpce-ecrapi:
resource "aws_vpc_endpoint" "vpce-ecrapi" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  private_dns_enabled = true
  route_table_ids     = []
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
    aws_security_group.cluster-sg.id
  ]
  service_name = "com.amazonaws.us-east-1.ecr.api"
  subnet_ids = [
    aws_subnet.subnet-i3.id,
    aws_subnet.subnet-i1.id,
    aws_subnet.subnet-i2.id,
  ]
  tags              = {}
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.cluster.id

  timeouts {}
}

# aws_vpc_endpoint.vpce-ecrdkr:
resource "aws_vpc_endpoint" "vpce-ecrdkr" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  private_dns_enabled = true
  route_table_ids     = []
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
    aws_security_group.cluster-sg.id
  ]
  service_name = "com.amazonaws.us-east-1.ecr.dkr"
  subnet_ids = [
    aws_subnet.subnet-i3.id,
    aws_subnet.subnet-i1.id,
    aws_subnet.subnet-i2.id,
  ]
  tags              = {}
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.cluster.id

  timeouts {}
}

# aws_vpc_endpoint.vpce-ec2:
resource "aws_vpc_endpoint" "vpce-elb" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  private_dns_enabled = true
  route_table_ids     = []
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
    aws_security_group.cluster-sg.id
  ]
  service_name = "com.amazonaws.us-east-1.elasticloadbalancing"
  subnet_ids = [
    aws_subnet.subnet-i3.id,
    aws_subnet.subnet-i1.id,
    aws_subnet.subnet-i2.id,
  ]
  tags              = {}
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.cluster.id

  timeouts {}
}

# aws_vpc_endpoint.vpce-logs:
resource "aws_vpc_endpoint" "vpce-logs" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  private_dns_enabled = true
  route_table_ids     = []
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
    aws_security_group.cluster-sg.id
  ]
  service_name = "com.amazonaws.us-east-1.logs"
  subnet_ids = [
    aws_subnet.subnet-i3.id,
    aws_subnet.subnet-i1.id,
    aws_subnet.subnet-i2.id,
  ]
  tags              = {}
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.cluster.id

  timeouts {}
}

# aws_vpc_endpoint.vpce-s3:
resource "aws_vpc_endpoint" "vpce-s3" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
      Version = "2008-10-17"
    }
  )
  private_dns_enabled = false
  route_table_ids = [
    aws_route_table.rtb-p1.id,
    aws_route_table.rtb-p2.id,
    aws_route_table.rtb-p3.id,
    aws_route_table.rtb-i.id,
  ]
  security_group_ids = []
  service_name       = "com.amazonaws.us-east-1.s3"
  subnet_ids         = []
  tags               = {}
  vpc_endpoint_type  = "Gateway"
  vpc_id             = aws_vpc.cluster.id

  timeouts {}
}

# aws_vpc_endpoint.vpce-sts:
resource "aws_vpc_endpoint" "vpce-sts" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  private_dns_enabled = true
  route_table_ids     = []
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
    aws_security_group.cluster-sg.id
  ]
  service_name = "com.amazonaws.us-east-1.sts"
  subnet_ids = [
    aws_subnet.subnet-i3.id,
    aws_subnet.subnet-i1.id,
    aws_subnet.subnet-i2.id,
  ]
  tags              = {}
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.cluster.id

  timeouts {}
}

resource "aws_vpc_endpoint" "vpce-eks" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  private_dns_enabled = true
  route_table_ids     = []
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
    aws_security_group.cluster-sg.id
  ]
  service_name = "com.amazonaws.us-east-1.eks"
  subnet_ids = [
    aws_subnet.subnet-i3.id,
    aws_subnet.subnet-i1.id,
    aws_subnet.subnet-i2.id,
  ]
  tags              = {}
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.cluster.id

  timeouts {}
}


resource "aws_vpc_endpoint" "vpce-grafana" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
    }
  )
  private_dns_enabled = true
  route_table_ids     = []
  security_group_ids = [
    aws_security_group.allnodes-sg.id,
    aws_security_group.cluster-sg.id
  ]
  service_name = "com.amazonaws.us-east-1.grafana"
  subnet_ids = [
    aws_subnet.subnet-i3.id,
    aws_subnet.subnet-i1.id,
    aws_subnet.subnet-i2.id,
  ]
  tags              = {}
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.cluster.id

  timeouts {}
}