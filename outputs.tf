output "tgw_spoke_route_table_ids" {
  value = aws_ec2_transit_gateway_route_table.spoke.id
}

output "tgw_firewall_route_table_ids" {
  value = aws_ec2_transit_gateway_route_table.firewall.id
}

output "tgw_id" {
  value = aws_ec2_transit_gateway.tgw.id
}

output "tgw_vpc_attachment_ids" {
  value = { for k, v in aws_ec2_transit_gateway_vpc_attachment.vpc_attachments : k => v.id }
}

output "tgw_vpc_inspection_attachment_ids" {
  value = { for k, v in aws_ec2_transit_gateway_vpc_attachment.inspection : k => v.id }
}
