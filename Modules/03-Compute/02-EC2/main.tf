resource "aws_instance" "this" {
  for_each = var.instances

  ami                    = each.value.ami_id
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id != "" ? each.value.subnet_id : (lookup(each.value.tags, "Tier", "public") == "private" ? var.private_subnet_ids[0] : var.public_subnet_ids[0])
  vpc_security_group_ids = length(each.value.security_group_ids) > 0 ? each.value.security_group_ids : var.default_security_group_ids
  key_name               = each.value.key_name != "" ? each.value.key_name : var.default_key_name

  user_data = each.value.user_data != "" ? try(
    file(each.value.user_data),
    try(
      file("${path.module}/${each.value.user_data}"),
      each.value.user_data
    )
  ) : null
  user_data_replace_on_change = true

  tags = merge(each.value.tags, {
    Name        = "${var.projectname}-${var.environment}-${each.key}"
    Environment = var.environment
    Projectname = var.projectname
  })
}