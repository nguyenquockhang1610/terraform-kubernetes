resource "aws_vpc_endpoint" "vpce-s3" {
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
      Version = "2008-10-17"
    }
  )
  private_dns_enabled = false
  route_table_ids = [
    aws_route_table.rtb-0102c621469c344cd.id,
    aws_route_table.rtb-0329e787bbafcb2c4.id,
    aws_route_table.rtb-041267f0474c24068.id,
  ]
  security_group_ids = []
  service_name       = "com.amazonaws.us-east-1.s3"
  subnet_ids         = []
  tags               = {}
  vpc_endpoint_type  = "Gateway"
  vpc_id             = aws_vpc.cluster.id

  timeouts {}
}
