resource "aws_ecs_service" "ECS-Service" {
  name                               = "my-service"
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  cluster                            = "arn:aws:ecs:us-east-1:620453548539:cluster/static-web-cluster"
  task_definition                    = "arn:aws:ecs:us-east-1:620453548539:task-definition/static-web:1"
  scheduling_strategy                = "REPLICA"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  network_configuration {
    assign_public_ip = true
    security_groups  = ["sg-059f27f655f756c90"]
    subnets          = ["subnet-03327bf4425257dc1"]
  }
}