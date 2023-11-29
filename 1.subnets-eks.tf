# aws_subnet.subnet-i1:
resource "aws_subnet" "subnet-i1" {
  depends_on                      = [aws_vpc_ipv4_cidr_block_association.vpc-cidr-assoc]
  assign_ipv6_address_on_creation = false
  availability_zone               = "ap-southeast-1a"
  cidr_block                      = "100.64.0.0/18"
  map_public_ip_on_launch         = false
  tags = {
    "Name"                                                                 = format("i1-%s", aws_ssm_parameter.tf-eks-cluster-name.value)
    "kubernetes.io/cluster/${aws_ssm_parameter.tf-eks-cluster-name.value}" = "shared"
  }
  vpc_id = aws_vpc.cluster.id
}

resource "aws_subnet" "subnet-i2" {
  depends_on                      = [aws_vpc_ipv4_cidr_block_association.vpc-cidr-assoc]
  assign_ipv6_address_on_creation = false
  availability_zone               = "ap-southeast-1b"
  cidr_block                      = "100.64.64.0/18"
  map_public_ip_on_launch         = false
  tags = {
    "Name"                                                                 = format("i2-%s", aws_ssm_parameter.tf-eks-cluster-name.value)
    "kubernetes.io/cluster/${aws_ssm_parameter.tf-eks-cluster-name.value}" = "shared"
  }
  vpc_id = aws_vpc.cluster.id
}

resource "aws_subnet" "subnet-i3" {
  depends_on                      = [aws_vpc_ipv4_cidr_block_association.vpc-cidr-assoc]
  assign_ipv6_address_on_creation = false
  availability_zone               = "ap-southeast-1c"
  cidr_block                      = "100.64.128.0/18"
  map_public_ip_on_launch         = false
  tags = {
    "Name"                                                                 = format("i3-%s", aws_ssm_parameter.tf-eks-cluster-name.value)
    "kubernetes.io/cluster/${aws_ssm_parameter.tf-eks-cluster-name.value}" = "shared"
  }
  vpc_id = aws_vpc.cluster.id
}


resource "aws_subnet" "subnet-p1" {
  assign_ipv6_address_on_creation = false
  availability_zone               = "ap-southeast-1a"
  cidr_block                      = "10.0.1.0/24"
  map_public_ip_on_launch         = false
  tags = {
    "Name"                                                                 = "Private1"
    "kubernetes.io/cluster/${aws_ssm_parameter.tf-eks-cluster-name.value}" = "shared"
    "kubernetes.io/role/internal-elb"                                      = "1"
  }
  vpc_id = aws_vpc.cluster.id
}

resource "aws_subnet" "subnet-p2" {
  assign_ipv6_address_on_creation = false
  availability_zone               = "ap-southeast-1b"
  cidr_block                      = "10.0.2.0/24"
  map_public_ip_on_launch         = false
  tags = {
    "Name"                                                                 = "Private2"
    "kubernetes.io/cluster/${aws_ssm_parameter.tf-eks-cluster-name.value}" = "shared"
    "kubernetes.io/role/internal-elb"                                      = "1"
  }
  vpc_id = aws_vpc.cluster.id
}

resource "aws_subnet" "subnet-p3" {
  assign_ipv6_address_on_creation = false
  availability_zone               = "ap-southeast-1c"
  cidr_block                      = "10.0.3.0/24"
  map_public_ip_on_launch         = false
  tags = {
    "Name"                                                                 = "Private3"
    "kubernetes.io/cluster/${aws_ssm_parameter.tf-eks-cluster-name.value}" = "shared"
    "kubernetes.io/role/internal-elb"                                      = "1"
  }
  vpc_id = aws_vpc.cluster.id
}
