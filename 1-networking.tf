provider "aws" {
  region = "us-east-1"  # Update with your desired AWS region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  # Update with your desired VPC CIDR block

  tags = {
    Name = "MainVPC"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MainIGW"
  }
}

resource "aws_subnet" "public" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index}.0/24"  # Update with your desired public subnet CIDR blocks
  availability_zone = "us-east-1a"  # Update with desired availability zone

  tags = {
    Name = "PublicSubnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 10}.0/24"  # Update with your desired private subnet CIDR blocks
  availability_zone = "us-east-1a"  # Update with desired availability zone

  tags = {
    Name = "PrivateSubnet-${count.index}"
  }
}






resource "aws_security_group" "rds" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access from all sources (publicly accessible)

    # You can also restrict access to specific IP ranges:
    # cidr_blocks = ["10.0.0.0/24", "192.168.1.0/24"]

    # If you have an application load balancer (ALB), you can allow access from its security group:
    # security_groups = [aws_security_group.alb.id]
  }

  # If you want to allow outbound internet access from the RDS instances, add egress rules:
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDSSecurityGroup"
  }
}


