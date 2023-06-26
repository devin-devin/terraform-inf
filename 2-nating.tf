resource "aws_eip" "nat" {
  count = 3

  vpc = true

  tags = {
    Name = "NAT-EIP-${count.index}"
  }
}

resource "aws_nat_gateway" "nat" {
  count = 3

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "NAT-Gateway-${count.index}"
  }
}

resource "aws_route_table" "private" {
  count    = 3
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "PrivateRouteTable-${count.index}"
  }
}

resource "aws_route" "private_nat" {
  count                  = 3
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}
