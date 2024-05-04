resource "aws_launch_template" "pftd_lt" {
  name_prefix = var.name_prefix
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name  = var.key_name
  vpc_security_group_ids = [aws_security_group.pftd_autoscaling_sg.id]

 block_device_mappings {
    device_name = var.device_name

    ebs {
      volume_size = var.volume_size
    }
  }
  user_data = filebase64("${path.module}/userdata.sh")
  
}

resource "aws_autoscaling_group" "pftd_asg_group" {
  name               = "PFTD-ASG"
  desired_capacity   = var.desired_capacity
  min_size           = var.min_size 
  max_size             = var.max_size
  vpc_zone_identifier  = var.subnet_ranges
  

  

  launch_template {
    id      = aws_launch_template.pftd_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "PFTD-Application"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_policy" "pftd_asg_policy" {
  name                   = "PFTD_asg_policy"
  scaling_adjustment     = var.scaling_adjustment 
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.pftd_asg_group.name
  
}
