# EC2 instance standalone
# -----------
# resource "aws_instance" "sharmi_instance" {
#   ami           = "ami-00c39f71452c08778"
#   instance_type = "t2.micro"
# }
# -----------

# ASG with Launch template
resource "aws_launch_template" "kito_ec2_launch_templ" {
  name_prefix   = "kito_ec2_launch_templ"
  image_id      = "ami-00c39f71452c08778" #specific for each region
  instance_type = "t2.micro"
  user_data     = filebase64("user_data.sh")

  key_name      = "kito"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.kito_sg_for_ec2.id]
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "kito-instance"
    }
  }
}

resource "aws_autoscaling_group" "kito_asg" {
  # no of instances
  desired_capacity = 1
  max_size         = 2
  min_size         = 1

    # Use both subnets in different AZs
  vpc_zone_identifier = [aws_subnet.kito_subnet_1.id,aws_subnet.kito_subnet_2.id]

  # source
  target_group_arns = [aws_lb_target_group.kito_alb_tg.arn]

  launch_template {
    id      = aws_launch_template.kito_ec2_launch_templ.id
    version = "$Latest"
  }

   # tags
  tag {
    key                 = "Name"
    value               = "kito-instance"
    propagate_at_launch = true
  }
}

# 502 error when instance is in private subnet w/ nat gateway
# https://stackoverflow.com/a/53861750
# 502 - Probably Apache/Server not running b/c it’s not installed because there's no nat gw or method to install software.