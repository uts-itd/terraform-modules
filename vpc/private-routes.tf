resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    module.vpc_labels.tags,
    { "Name" = local.public_routetable_name },
  )
}

resource "aws_route" "private_default_egress" {
  count = length(aws_nat_gateway.main)

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[count.index].id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}