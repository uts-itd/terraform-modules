resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    module.vpc_labels.tags,
    { "Name" = local.internetgateway_name }
  )
}