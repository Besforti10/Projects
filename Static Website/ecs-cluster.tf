resource "aws_ecs_cluster" "ECS" {
  name = "static-web-cluster"

  tags = {
    Name = "static-web-cluster"
  }
}   