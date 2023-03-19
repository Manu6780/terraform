resource "aws_instance" "vprofile-bastion-host" {
  ami = lookup(var.amis,var.region )
  instance_type = "t2.micro"
  key_name = aws_key_pair.vprofilekey.key_name
  subnet_id = module.vpc.public_subnets[0]
  count = var.instance_count
  security_groups = [aws_security_group.vprofile_bastion_sg.id]

  tags = {
    Name = "Vprofile-bastion"
    Project = "vprofile"
  }

  provisioner "file" {
    content = templatefile("db-deploy.tmpl",{ rds-endpoint = aws_db_instance.vprofile_rds.address, dbuser = var.dbuser, dbpass = var.dbpass } )
    destination = "tmp/vprofile-deploy.sh"
  }
  provisioner "remote-exec" {
    inline = [
    "chmod +x tmp/vprofile-deploy.sh",
    "sudo tmp/vprofile-deploy.sh"
    ]

    connection {
      user = var.user
      private_key = file(var.priv_key)
      host = self.public_ip
    }
  }
  depends_on = [aws_db_instance.vprofile_rds]

}