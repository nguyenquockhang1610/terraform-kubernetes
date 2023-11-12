# Tạo VPC cho bastion
resource "aws_vpc" "bastion_vpc" {
  cidr_block            = "10.0.0.0/16"  # Thay đổi CIDR Block cho VPC
  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = {
    Name = "Bastion VPC"
  }
}

# Tạo Subnet cho bastion
resource "aws_subnet" "bastion_subnet" {
  vpc_id                  = aws_vpc.bastion_vpc.id
  cidr_block             = "10.0.0.0/24"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Bastion Subnet"
  }
}

# Tạo Security Group cho bastion
resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.bastion_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  

  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
}

# Tạo bastion instance
resource "aws_instance" "bastion" {
  instance_type          = "t3.micro"
  ami                    = "ami-05c13eab67c5d8861"
  subnet_id              = aws_subnet.bastion_subnet.id
  tags = {
    Name = "bastion"
  }

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
}

