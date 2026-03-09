resource "aws_iam_role" "mysql" {
  name = local.mysql_role_name   # Roboshop-Dev-Mysql

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    local.common_tags,
    {
      Name = local.mysql_role_name
    }
  )
}

resource "aws_iam_policy" "mysql" {
  name        = local.mysql_policy_name
  description = "A policy for mysql EC2 instance to read SSM parameters"
  policy      = templatefile("mysql-iam-policy.json", {
    ENV = var.environment
  })
}

resource "aws_iam_role_policy_attachment" "mysql" {
  role       = aws_iam_role.mysql.name
  policy_arn = aws_iam_policy.mysql.name
}

resource "aws_iam_instance_profile" "mysql" {
  name = "${var.project}-${var.environment}-mysql"
  role = aws_iam_role.mysql.name
}