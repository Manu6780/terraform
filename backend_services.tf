resource "aws_db_subnet_group" "vprofile-rds-subgrp" {
  subnet_ids = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]
  tags = {
    Name = "Subnet Group for RDS"
  }
}
resource "aws_elasticache_subnet_group" "Vprofile_ecache_subgrp" {
  name       = "Vprofile_ecache_subgrp"
  subnet_ids = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]

  tags = {
    Name = "Vprofile_ecache_subgrp"
  }
}

resource "aws_db_instance" "vprofile_rds" {
  instance_class = "db.t2.micro"
  allocated_storage = 20
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "5.6.34"
  db_name = var.dbname
  username = var.dbuser
  password = var.dbpass
  parameter_group_name = "default.mysql5.6"
  multi_az = "false"
  publicly_accessible = "false"
  skip_final_snapshot = "true"
  vpc_security_group_ids = [aws_security_group.vprofile_backend_sg.id]
  db_subnet_group_name = aws_db_subnet_group.vprofile-rds-subgrp.name
}

resource "aws_elasticache_cluster" "vprofile_cache" {
  cluster_id = "vprofile_cache"
  engine = "memcached"
  node_type = "cache.t2.micro"
  parameter_group_name = "default.memcached.5"
  port = 11211
  security_group_ids = [aws_security_group.vprofile_backend_sg.id]
  subnet_group_name = aws_elasticache_subnet_group.Vprofile_ecache_subgrp.name
}

resource "aws_mq_broker" "vprofile-rmq" {
  broker_name        = "vprofile-rmq"
  engine_type        = "ActiveMq"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups = [aws_security_group.vprofile_backend_sg.id]
  subnet_ids = [module.vpc.private_subnets[0]]
  user {
    password = var.rmquser
    username = var.rmqpass
  }
}

