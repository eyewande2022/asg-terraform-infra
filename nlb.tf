resource "aws_lb" "pftd_nlb" {
  name               = "pftd-nlb"
  internal           = false
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnet_ranges

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_listener" "pftd_listener" {
default_action {
  type= "forward"
  target_group_arn = aws_lb_target_group.pftd_tg.arn
}

load_balancer_arn = aws_lb.pftd_nlb.arn
port = 80
protocol = "TCP"

}


resource "aws_lb_target_group" "pftd_tg" {
  target_type = var.target_type
  name = "cma-tg"
  port = 80
  protocol = "TCP"
  vpc_id = var.vpc_id
  health_check {
    port                = "traffic-port"
    protocol            = "TCP"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
  tags = {
    Name = "pftd-tg"
  }

}

resource "aws_autoscaling_attachment" "pftd_asg_attachment" {
autoscaling_group_name = aws_autoscaling_group.pftd_asg_group.name
lb_target_group_arn = aws_lb_target_group.pftd_tg.arn

}



data "aws_autoscaling_groups" "cma_asg_groups" {
  names = ["CMA-ASG"]
}
