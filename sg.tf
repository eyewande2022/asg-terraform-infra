# Security group for AutoScaling group 
resource "aws_security_group" "pftd_autoscaling_sg" {
  name        = "PFTD-security-group-sg"
  description = "security group for instance in ASG "
  vpc_id      = var.vpc_id
  tags = {
    Name = "PFTD-sg"

  }

}


resource "aws_security_group_rule" "ingress_https_access" {
  type              = "ingress"
  description       = "HTTPS access"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pftd_autoscaling_sg.id


}


resource "aws_security_group_rule" "ingress_ssh_access" {
  type              = "ingress"
  description       = "SSH access"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pftd_autoscaling_sg.id


}




resource "aws_security_group_rule" "ingress_http_access" {
  type              = "ingress"
  description       = "HTTP access"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pftd_autoscaling_sg.id


}



resource "aws_security_group_rule" "egress_http_access" {
  type              = "egress"
  description       = "All traffic access to our VPC "
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pftd_autoscaling_sg.id

}




# Security group for Network LB

resource "aws_security_group" "pftd_nlb_sg" {
  name        = "pftd-nlb-sg"
  description = "security group for HTTP"
  vpc_id      = var.vpc_id

  tags = {
    Name = "pftd-nlb-sg"

  }

}



resource "aws_security_group_rule" "ingress_http_nlb_access" {
  type              = "ingress"
  description       = "HTTP access"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pftd_nlb_sg.id


}

resource "aws_security_group_rule" "ingress_https_nlb_access" {
  type              = "ingress"
  description       = "HTTPS access"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.pftd_nlb_sg.id


}



resource "aws_security_group_rule" "egress_http_nlb_access" {
  type              = "egress"
  description       = "All traffic access to our VPC "
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["172.31.0.0/16"]
  security_group_id = aws_security_group.pftd_nlb_sg.id

}
