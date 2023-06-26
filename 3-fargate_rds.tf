resource "aws_ecs_task_definition" "fargate_task" {
  count = 3

  family                   = "FargateTask-${count.index}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  # Add your task definition configurations here

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<DEFINITION
[
  {
    "name": "my-container",
    "image": "your-image-url",
    "portMappings": [
      {
        "containerPort": 80,
        "protocol": "tcp"
      }
    ]
  }
]
DEFINITION
}






resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "testercluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.08.0"
  database_name           = "mydatabase"
  master_username         = "admin"
  master_password         = "your-password"
  backup_retention_period = 7
  preferred_backup_window = "02:00-03:00"

  vpc_security_group_ids = [aws_security_group.rds.id]

  tags = {
    Name = "AuroraCluster"
  }
}

resource "aws_rds_cluster_instance" "read_replica" {
  count                   = 3
  cluster_identifier      = aws_rds_cluster.aurora_cluster.id
  instance_class          = "db.t2.micro"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.08.0"
  identifier              = "aurorareadreplica-${count.index}"
  publicly_accessible    = false

  tags = {
    Name = "aurorareadreplica-${count.index}"
  }
}

