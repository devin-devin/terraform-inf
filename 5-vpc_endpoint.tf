
resource "aws_security_group" "client_endpoint" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow inbound HTTPS traffic from all sources

    # You can also restrict access to specific IP ranges:
    # cidr_blocks = ["10.0.0.0/24", "192.168.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic to all destinations

    # Add more specific egress rules if needed
  }

  tags = {
    Name = "ClientEndpointSecurityGroup"
  }
}


resource "aws_vpc_endpoint" "client_endpoint" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-east-1.ecr.api"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.client_endpoint.id]
  subnet_ids          = aws_subnet.private[*].id

  tags = {
    Name = "ClientEndpoint"
  }
}

