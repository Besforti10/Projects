resource "aws_ecs_task_definition" "Taskdefinition" {
  family                   = "static-web"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::620453548539:role/ecsTaskExecutionRole"
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  container_definitions = jsonencode([
    {
      name      = "main-container"
      image     = "620453548539.dkr.ecr.us-east-1.amazonaws.com/static-web:latest"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}