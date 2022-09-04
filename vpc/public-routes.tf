resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    module.vpc_labels.tags,
    { "Name" = local.public_routetable_name },
  )
}

resource "aws_route" "public_default_egress" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}