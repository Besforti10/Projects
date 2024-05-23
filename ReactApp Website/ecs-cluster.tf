resource "aws_ecs_cluster" "ECS" {
  name = "besforti-cluster"

  tags = {
    Name = "besforti-cluster"
  }
}   