variable "region" {
  default = "us-east-1"
}
variable "zone1" {
  default = "us-east-1a"
}

variable "zone2" {
  default = "us-east-1b"
}

variable "amis" {
  type = map(any)
  default = {
    us-east-1 = "ami-005f9685cb30f234b"
    us-east-2 = "ami-00eeedc4036573771"
  }
}
variable priv_key {
  default = "vprofileprivkey"
}

variable "pub_key" {
  default = "vprofileprivkey.pub"
}

variable "user" {
  default = "ubuntu"
}

variable "myip" {
  default = "0.0.0.0/0"
}

variable "rmquser" {
  default = "rabbit"
}

variable "rmqpass" {
  default = "Manu24056@321"
}

variable "dbname" {
  default = "accounts"
}

variable "dbuser" {
  default = "admim"
}

variable "dbpass" {
  default = "admin123"
}

variable "instance_count" {
  default = "1"
}

variable "vpc_name" {
  default = "vprofile_vpc"

}

variable "vpc_cidr" {
  default = "172.21.0.0/16"
}

variable "pub_sub_cidr_1" {
  default = "172.21.1.0/24"
}

variable "pub_sub_cidr_2" {
  default = "172.21.2.0/24"
}


variable "priv_sub_cidr_1" {
  default = "172.21.3.0/24"
}


variable "priv_sub_cidr_2" {
  default = "172.21.4.0/24"
}