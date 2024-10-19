
# Target group vs Auto scaling group
# https://stackoverflow.com/a/53322509
# https://stackoverflow.com/a/52364066

resource "aws_lb" "kito_lb" {
  name               = "kito-lb-asg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.kito_sg_for_elb.id]
  subnets            = [aws_subnet.kito_subnet_1.id, aws_subnet.kito_subnet_2.id]
  depends_on         = [aws_internet_gateway.kito_gw]
}

resource "aws_lb_target_group" "kito_alb_tg" {
  name     = "kito-tf-lb-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.kito_main.id
}

resource "aws_lb_listener" "kito_front_end" {
  load_balancer_arn = aws_lb.kito_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kito_alb_tg.arn
  }
}