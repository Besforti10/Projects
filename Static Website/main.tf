resource "aws_security_group" "alb_sg" {  
  name        = "static-web"
  description = "Security Group for Application Load Balancer"
  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "static-web"
  }
}
resource "aws_security_group" "ecs_sg" {
  name        = "static-web-ecs"
  description = "Security Group for Web Server Instances"

  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "static-web-ecs"
  }
}

resource "aws_lb" "app_lb" {    
  name               = "static-web-lb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnet[*].id
  depends_on         = [aws_internet_gateway.igw_vpc]
}

resource "aws_lb_target_group" "alb_ecs_tg" { 
  name     = "static-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.custom_vpc.id
  tags = {
    Name = "static-web-tg"
  }
}
resource "aws_lb_listener" "alb_listener" { 
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ecs_tg.arn
  }
  tags = {
    Name = "static-web-alb-listener"
  }
}