variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the AWS side of a Border Gateway Protocol (BGP) session. You can use the default ASN, or you can specify a private ASN in the 64512-65534 or 4200000000-4294967294 ranges."
  type        = number
  default     = 64512
}

variable "description" {
  description = "Set the description of your transit gateway to help you identify it in the future."
  type        = string
  default     = ""
}

variable "enable_mutlicast_support" {
  description = "Enables the ability to create multicast domains in this transit gateway."
  type        = bool
  default     = false
}

variable "enable_vpn_ecmp_support" {
  description = "Equal cost multipath (ECMP) routing for VPN Connections that are attached to this transit gateway."
  type        = bool
  default     = true
}

variable "prefix" {
  description = "The descriptio for each environment, ie: bin-dev"
  type        = string
}

variable "tags" {
  description = "The tags for the resources"
  type        = map(any)
  default     = {}
}

variable "tgw_name" {
  description = "TGW Name"
  type        = string
}

variable "transit_gateway_cidr_blocks" {
  description = "One or more IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a size /24 CIDR block or larger for IPv4, or a size /64 CIDR block or larger for IPv6"
  type        = list(string)
  default     = []
}

variable "timeouts" {
  description = "Create, update, and delete timeout configurations for the transit gateway"
  type        = map(string)
  default     = {}
}

variable "vpc_attachments" {
  description = "vpc and subnet ids for attachment transit gateway"
  type = map(object({
    vpc_id     = string
    subnet_ids = list(string)
  }))
}

variable "vpc_inspection_attachments" {
  description = "vpc and subnet ids for attachment transit gateway"
  type = map(object({
    vpc_id     = string
    subnet_ids = list(string)
  }))
}
