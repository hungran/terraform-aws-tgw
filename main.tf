################################################################################
# Transit Gateway
################################################################################

resource "aws_ec2_transit_gateway" "tgw" {
  description                     = coalesce(var.description, var.tgw_name)
  amazon_side_asn                 = "64512"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  auto_accept_shared_attachments  = "enable"
  multicast_support               = var.enable_mutlicast_support ? "enable" : "disable"
  vpn_ecmp_support                = var.enable_vpn_ecmp_support ? "enable" : "disable"
  dns_support                     = "enable"
  transit_gateway_cidr_blocks     = var.transit_gateway_cidr_blocks

  timeouts {
    create = try(var.timeouts.create, null)
    update = try(var.timeouts.update, null)
    delete = try(var.timeouts.delete, null)
  }

  tags = merge(
    var.tags,
    {
      "Name" : "${var.prefix}-tgw-${var.tgw_name}"
    }
  )
}

################################################################################
# Route Table / Routes
################################################################################

resource "aws_ec2_transit_gateway_route_table" "spoke" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = merge(
    var.tags,
    {
      "Name" : "${var.prefix}-tgw-${var.tgw_name}-rtb-spoke"
    }
  )
}

resource "aws_ec2_transit_gateway_route_table" "firewall" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  tags = merge(
    var.tags,
    {
      "Name" : "${var.prefix}-tgw-${var.tgw_name}-rtb-firewall"
    }
  )
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attachments" {
  for_each = var.vpc_attachments

  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = each.value.vpc_id
  subnet_ids         = each.value.subnet_ids

  dns_support                                     = "enable"
  ipv6_support                                    = "disable"
  appliance_mode_support                          = "enable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  tags = merge(
    var.tags,
    {
      "Name" : "${var.prefix}-tgw-${var.tgw_name}-vpc-attachment-${each.key}"
    }
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc_associate_spoke_rtb" {
  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.vpc_attachments
  ]
  for_each = aws_ec2_transit_gateway_vpc_attachment.vpc_attachments

  transit_gateway_attachment_id  = each.value.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_propagate_firewall_rbt" {
  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.vpc_attachments
  ]
  for_each = aws_ec2_transit_gateway_vpc_attachment.vpc_attachments

  transit_gateway_attachment_id  = each.value.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.firewall.id
}

# resource "aws_ec2_transit_gateway_route" "vpn_routes" {
#   depends_on = [
#     aws_ec2_transit_gateway_route_table.vpn
#   ]
#   for_each = var.vpn_routes

#   transit_gateway_attachment_id  = var.transit_gateway_attachment_vpn_id
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpn.id
#   destination_cidr_block         = each.value.vpn_routes
# }

resource "aws_ec2_transit_gateway_vpc_attachment" "inspection" {
  for_each = var.vpc_inspection_attachments

  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = each.value.vpc_id
  subnet_ids         = each.value.subnet_ids

  dns_support                                     = "enable"
  ipv6_support                                    = "disable"
  appliance_mode_support                          = "enable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  tags = merge(
    var.tags,
    {
      "Name" : "${var.prefix}-tgw-${var.tgw_name}-inspection-vpc-attachment-${each.key}"
    }
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "vpc_inspection_associate_rtb" {
  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.inspection
  ]
  for_each = aws_ec2_transit_gateway_vpc_attachment.inspection

  transit_gateway_attachment_id  = each.value.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.firewall.id
}

resource "aws_ec2_transit_gateway_route" "inspection" {
  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.inspection
  ]
  for_each = aws_ec2_transit_gateway_vpc_attachment.inspection

  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = each.value.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.spoke.id
}
