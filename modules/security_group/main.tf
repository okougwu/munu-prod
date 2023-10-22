resource "aws_security_group" "my_security_groups" {
  name        = "${var.project_name}-security-group"
  description = "Example security group for your VPC"

  count = length(var.allowed_ports)

  ingress {
    from_port   = var.allowed_ports[count.index]
    to_port     = var.allowed_ports[count.index]
    protocol    = var.allowed_protocols[count.index]
    cidr_blocks = [var.allowed_cidr_blocks[count.index]]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my_security_groups"
  }
}


