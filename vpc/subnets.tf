resource "aws_subnet" "public" {
  count = var.is_highavailable ? length(data.aws_availability_zones.available.names) : 1

  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.cidr_block, var.subnet_bits, count.index)

  tags = merge(
    module.vpc_labels.tags,
    { "Name" = "${local.public_subnet_name}-${count.index}" },
  )
}

resource "aws_subnet" "private" {
  count = var.is_highavailable ? length(data.aws_availability_zones.available.names) : 1

  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.cidr_block, var.subnet_bits, count.index + 3)

  tags = merge(
    module.vpc_labels.tags,
    { "Name" = "${local.private_subnet_name}-${count.index}" },
  )
}
