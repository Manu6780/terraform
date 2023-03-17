resource "aws_key_pair" "vprofilekey" {
  public_key = file(var.pub_key)
  key_name   = "vprofilekey"
}