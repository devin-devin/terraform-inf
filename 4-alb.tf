resource "aws_security_group" "alb" {
  vpc_id = aws_vpc.main.id

  # Add your ALB security group configurations here

  tags = {
    Name = "ALBSecurityGroup"
  }
}

resource "aws_lb" "alb" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.public[*].id

  tags = {
    Name = "ALB"
  }
}

resource "aws_lb_target_group" "fargate_target_group" {
  count     = 3
  name      = "FargateTargetGroup-${count.index}"
  port      = 80
  protocol  = "HTTP"
  target_type = "ip"
  vpc_id    = aws_vpc.main.id

  tags = {
    Name = "FargateTargetGroup-${count.index}"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fargate_target_group[0].arn
  }
}
