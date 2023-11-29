# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.cluster.id

  tags = {
    Name = "Bastion IGW"
  }
}

# Create subnets in the Bastion VPC
resource "aws_subnet" "bastion_subnet1" {
  vpc_id            = aws_vpc.cluster.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "Bastion Subnet 1"
  }
}

resource "aws_subnet" "bastion_subnet2" {
  vpc_id            = aws_vpc.cluster.id
  cidr_block        = "100.64.192.0/18"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "Bastion Subnet 2"
  }
}

# Create a security group for the Bastion instance
resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.cluster.id
  tags = {
    Name = "Bastion"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a route table for the Bastion subnets
resource "aws_route_table" "bastion_route_table" {
  vpc_id = aws_vpc.cluster.id

  tags = {
    Name = "Bastion Route Table"
  }
}

# Add a route to Internet Gateway for each subnet
resource "aws_route" "bastion_igw_route" {
  route_table_id         = aws_route_table.bastion_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate route table with the Bastion subnets
resource "aws_route_table_association" "bastion_subnet_association1" {
  subnet_id      = aws_subnet.bastion_subnet1.id
  route_table_id = aws_route_table.bastion_route_table.id
}

resource "aws_route_table_association" "bastion_subnet_association2" {
  subnet_id      = aws_subnet.bastion_subnet2.id
  route_table_id = aws_route_table.bastion_route_table.id
}

resource "aws_network_acl" "bastion_nacl" {
  vpc_id = aws_vpc.cluster.id

  egress {
    protocol   = "-1"
    action     = "allow"
    rule_no    = 200
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0

  }

  ingress {
    protocol   = "6" # TCP
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80

  }

  tags = {
    Name = "bastion_nacl"
  }
}

resource "aws_network_acl" "lb_nacl" {
  vpc_id = aws_vpc.cluster.id

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0

  }

  ingress {
    protocol   = "6" # TCP
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80

  }

  tags = {
    Name = "lb_nacl"
  }
}



# Create the Bastion instances in each subnet
resource "aws_instance" "bastion1" {
  instance_type               = "t3.micro"
  ami                         = "ami-02453f5468b897e31"
  subnet_id                   = aws_subnet.bastion_subnet1.id
  associate_public_ip_address = true
  key_name                    = "eks"

  tags = {
    Name = "bastion1"

  }

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  user_data              = base64encode(local.eks-node-private-userdata)
}

resource "aws_instance" "bastion2" {
  instance_type               = "t3.micro"
  ami                         = "ami-02453f5468b897e31"
  subnet_id                   = aws_subnet.bastion_subnet2.id
  associate_public_ip_address = true
  key_name                    = "eks"

  tags = {
    Name = "bastion2",
  }

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  user_data              = base64encode(local.eks-node-private-userdata)
}

output "bastion1_public_ip" {
  value = aws_instance.bastion1.public_ip
}

output "bastion2_public_ip" {
  value = aws_instance.bastion2.public_ip
}

# Create the ALB in the Bastion VPC
resource "aws_lb" "eks_lb" {
  name               = "eks-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [aws_subnet.bastion_subnet1.id, aws_subnet.bastion_subnet2.id]

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
}

# Create the security group for the ALB
resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "Security group for the ALB"
  vpc_id      = aws_vpc.cluster.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.bastion_subnet1.cidr_block, aws_subnet.bastion_subnet2.cidr_block]
  }
}

# Create the target group for the ALB
resource "aws_lb_target_group" "eks_target_group" {
  name        = "eks-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.cluster.id
  target_type = "ip"
}

# Create the listener for the ALB
resource "aws_lb_listener" "eks_listener" {
  load_balancer_arn = aws_lb.eks_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.eks_target_group.arn
    type             = "forward"
  }
}

# Output the ALB DNS name
output "eks_lb_dns_name" {
  value = aws_lb.eks_lb.dns_name
}
