resource "aws_instance" "openvpn" {
  ami                    = local.openvpn_ami_id
  instance_type          = "t3.small"
  subnet_id              = local.public_subnet_id
  vpc_security_group_ids = [local.openvpn_sg_id]
  user_data              = file("openvpn_user_data.sh")

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-openvpn"
    }
  )
}