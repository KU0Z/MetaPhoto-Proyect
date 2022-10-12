# ROLE FOR ECS EXECUTION
resource "aws_iam_role" "ecs_service_role" {
  name = "CustomeECSTaskExecutionRole-${var.environment}"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Usage       = var.Usage
    Environment = var.environment
  }
}
# POLICY FOR TASK EXECUTION
data "aws_iam_policy" "ecs_service_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ATTACH POLICY FOR TASK EXECUTION TO ECS ROLE
resource "aws_iam_role_policy_attachment" "codedeploy_service_role_policy_attach" {
  role       = aws_iam_role.ecs_service_role.name
  policy_arn = data.aws_iam_policy.ecs_service_policy.arn
}
####################### CLOUD WATCH LOG GROUP #######################
resource "aws_cloudwatch_log_group" "meta_photos_api" {
  name = "/ecs/meta_photos/meta_photos-api"

  tags = {
    Usage       = var.Usage
    Environment = var.environment
    Application = "meta_photos-api"
  }
}


####################### CLUSTER #######################
resource "aws_ecs_cluster" "meta_photos_cluster_qa" {
  name = "meta_photos-qa"

  tags = {
    Name        = "meta_photos-cluster-qa",
    Usage       = var.Usage
    Environment = var.environment
    
  }
}

####################### ECS SERVICES #######################

####### API  #######

# Task Definition
resource "aws_ecs_task_definition" "meta_photos_api_task_def" {
  family = "meta_photos-api"
  tags = {
    Name        = "meta_photos-api"
    Usage       = var.Usage
    Environment = var.environment
    
  }
  container_definitions = jsonencode([
    {
      "name" : "meta_photos-api",
      "cpu" : 512,
      "memory" : 1024,
      "image" : var.ecr_meta_photos_api,
      "essential" : true,
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "secretOptions" : null,
        "options" : {
          "awslogs-group" : "/ecs/meta_photos/meta_photos-api",
          "awslogs-region" : var.aws_region,
          "awslogs-stream-prefix" : "ecs"
        }
      },
      "portMappings" : [
        {
          "containerPort" : var.app_port,
          "hostPort" : var.app_port,
          "protocol" : "tcp"
        }
      ],
      "environment" : [
      ]
    }
  ])
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  task_role_arn            = aws_iam_role.ecs_service_role.a4
  execution_role_arn       = aws_iam_role.ecs_service_role.arn
}

# ECS Service
resource "aws_ecs_service" "meta_photos_api" {
  name            = "meta-photos-api"
  cluster         = aws_ecs_cluster.meta_photos_cluster_qa.id
  desired_count   = 1
  task_definition = aws_ecs_task_definition.meta_photos_api_task_def.arn
  launch_type     = "FARGATE"
  propagate_tags  = "TASK_DEFINITION"
  tags = {
    Usage         = var.Usage
    Environment   = var.environment
  }

  network_configuration {
    security_groups  = [var.security_group]
    subnets          = [var.private_subnet_1, var.private_subnet_2]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.meta_photos_api_tg
    container_name   = "meta-photos-api"
    container_port   = var.app_port
  }
}

# Autoscaling Target
resource "aws_appautoscaling_target" "meta_photos_api_target" {
  max_capacity = 2
  min_capacity = 1
  resource_id = "service/${aws_ecs_cluster.meta_photos_cluster_qa.name}/${aws_ecs_service.meta_photos_api.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

# Autoscaling Memory Policy
resource "aws_appautoscaling_policy" "meta_photos_api_memory_policy" {
  name               = "meta_photos API - Autoscaling Memory Utilization"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.meta_photos_api_target.resource_id
  scalable_dimension = aws_appautoscaling_target.meta_photos_api_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.meta_photos_api_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value        = 80
    scale_in_cooldown   = 60
    scale_out_cooldown  = 60
  }
}

# Autoscaling CPU Policy
resource "aws_appautoscaling_policy" "meta_photos_api_cpu_policy" {
  name               = "meta_photos API  - Autoscaling CPU Utilization"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.meta_photos_api_target.resource_id
  scalable_dimension = aws_appautoscaling_target.meta_photos_api_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.meta_photos_api_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value        = 80
    scale_in_cooldown   = 60
    scale_out_cooldown  = 60
  }
}

output "api_meta_cluster_id" {
  value = aws_ecs_cluster.meta_photos_cluster_qa.id
}