resource "aws_security_group" "this" {
  for_each    = var.security_groups
  name        = "${var.projectname}-${var.environment}-${each.key}-sg"
  description = "Security group ${each.key} for ${var.projectname}-${var.environment}"
  vpc_id      = each.value.vpc_id != "" ? each.value.vpc_id : var.vpc_id_default

  dynamic "ingress" {
    for_each = each.value.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = each.value.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(each.value.tags, {
    Name        = "${var.projectname}-${var.environment}-${each.key}-sg"
    Environment = var.environment
    Projectname = var.projectname
  })
}
