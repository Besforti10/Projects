resource "aws_ecs_service" "ECS-Service" {
  name                               = "my-service"
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  cluster                            = "arn:aws:ecs:us-east-1:620453548539:cluster/besforti-cluster"
  task_definition                    = "arn:aws:ecs:us-east-1:620453548539:task-definition/besforti:1"
  scheduling_strategy                = "REPLICA"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  network_configuration {
    assign_public_ip = true
    security_groups  = ["sg-09fa9d26b4e473828"]
    subnets          = ["subnet-0ac70177fe3af441d"]
  }
}