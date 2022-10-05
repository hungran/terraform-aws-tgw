<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |
| [aws_ec2_transit_gateway_route.inspection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route_table.firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table.spoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.vpc_associate_spoke_rtb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_association.vpc_inspection_associate_rtb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_route_table_propagation.vpc_propagate_firewall_rbt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_propagation) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.inspection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.vpc_attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amazon_side_asn"></a> [amazon\_side\_asn](#input\_amazon\_side\_asn) | The Autonomous System Number (ASN) for the AWS side of a Border Gateway Protocol (BGP) session. You can use the default ASN, or you can specify a private ASN in the 64512-65534 or 4200000000-4294967294 ranges. | `number` | `64512` | no |
| <a name="input_description"></a> [description](#input\_description) | Set the description of your transit gateway to help you identify it in the future. | `string` | `""` | no |
| <a name="input_enable_mutlicast_support"></a> [enable\_mutlicast\_support](#input\_enable\_mutlicast\_support) | Enables the ability to create multicast domains in this transit gateway. | `bool` | `false` | no |
| <a name="input_enable_vpn_ecmp_support"></a> [enable\_vpn\_ecmp\_support](#input\_enable\_vpn\_ecmp\_support) | Equal cost multipath (ECMP) routing for VPN Connections that are attached to this transit gateway. | `bool` | `true` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The descriptio for each environment, ie: bin-dev | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags for the resources | `map(any)` | `{}` | no |
| <a name="input_tgw_name"></a> [tgw\_name](#input\_tgw\_name) | TGW Name | `string` | n/a | yes |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Create, update, and delete timeout configurations for the transit gateway | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_cidr_blocks"></a> [transit\_gateway\_cidr\_blocks](#input\_transit\_gateway\_cidr\_blocks) | One or more IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a size /24 CIDR block or larger for IPv4, or a size /64 CIDR block or larger for IPv6 | `list(string)` | `[]` | no |
| <a name="input_vpc_attachments"></a> [vpc\_attachments](#input\_vpc\_attachments) | vpc and subnet ids for attachment transit gateway | <pre>map(object({<br>    vpc_id     = string<br>    subnet_ids = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vpc_inspection_attachments"></a> [vpc\_inspection\_attachments](#input\_vpc\_inspection\_attachments) | vpc and subnet ids for attachment transit gateway | <pre>map(object({<br>    vpc_id     = string<br>    subnet_ids = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tgw_firewall_route_table_ids"></a> [tgw\_firewall\_route\_table\_ids](#output\_tgw\_firewall\_route\_table\_ids) | n/a |
| <a name="output_tgw_id"></a> [tgw\_id](#output\_tgw\_id) | n/a |
| <a name="output_tgw_spoke_route_table_ids"></a> [tgw\_spoke\_route\_table\_ids](#output\_tgw\_spoke\_route\_table\_ids) | n/a |
| <a name="output_tgw_vpc_attachment_ids"></a> [tgw\_vpc\_attachment\_ids](#output\_tgw\_vpc\_attachment\_ids) | n/a |
| <a name="output_tgw_vpc_inspection_attachment_ids"></a> [tgw\_vpc\_inspection\_attachment\_ids](#output\_tgw\_vpc\_inspection\_attachment\_ids) | n/a |
<!-- END_TF_DOCS -->