resource "aws_ecs_task_definition" "TD" {
  family                   = "besforti"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::620453548539:role/ecsTaskExecutionRole"
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "main-container"
      image     = "620453548539.dkr.ecr.us-east-1.amazonaws.com/azure-app:latest"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}