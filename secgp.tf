resource "aws_security_group" "vprofile_bean_sg" {
  name        = "vprofile_bean_sg"
  description = "Security group for Beanstalk"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "vprofile_bastion_sg" {
  name        = "vprofile_bastion_sg"
  description = "Security group for bastionisioner"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [var.myip]

  }
}
resource "aws_security_group" "vprofile_Beans_ec2_sg" {
  name        = "vprofile_Beans_ec2_sg"
  description = "vprofile Beans ec2sg"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.vprofile_bastion_sg.id]

  }

}

resource "aws_security_group" "vprofile_backend_sg" {
  name        = "vprofile_backend_sg"
  description = "vprofile backend sg"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 0
    protocol        = "tcp"
    to_port         = 0
    security_groups = [aws_security_group.vprofile_Beans_ec2_sg.id]

  }
}
resource "aws_security_group_rule" "backend_sg_allow_itself" {
  from_port                = 0
  protocol                 = "tcp"
  security_group_id        = aws_security_group.vprofile_backend_sg.id
  source_security_group_id = aws_security_group.vprofile_backend_sg.id
  to_port                  = 65535
  type                     = "ingress"
}