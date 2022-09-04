resource "aws_eip" "nat" {
  count = var.is_highavailable ? length(data.aws_availability_zones.available.names) : 1

  vpc = true
  tags = merge(
    module.vpc_labels.tags,
    { "Name" = "${local.elastic_ip_name}-${count.index}" },
  )
}

resource "aws_nat_gateway" "main" {
  count = length(aws_eip.nat)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = merge(
    module.vpc_labels.tags,
    { "Name" = "${local.nat_gateway_name}-${count.index}" },
  )
}

output "nat_gateway_ips" {
  value = aws_eip.nat.*.public_ip
}