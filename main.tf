terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.87.0"
    }
  }
}

provider "aws" {}

data "aws_ami" "ubuntu" {
  most_recent = true #bool

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
                                          # expression / reference
# local.image_id it returns a value of data.aws_ami.ubuntu.id equals to id of the image  "ami-0f9de6e2d2f067fca"
locals { # local expressions
  image_id = data.aws_ami.ubuntu.id # string
  
  
  my_family = {
    my_name_is = "anil"
    my_surname_is = "gencdogus"
    my_age_is = 32
    my_home_country_is = "turkey"
    my_favorite_topic_is = "terraform"
  }

  test_environment = {
    prefix = "test"
    instance_type = "t2.micro"
  }

  my_name_is = "anil"
  my_surname_is = "gencdogus"
  my_age_is = 32
  my_home_country_is = "turkey"
  my_favorite_topic_is = "terraform"
}

#Variable/Input Types of the values itself. 

#     string = collection of numbers and characters
#     provided within ""

#     list/array = ["dev", "t2.micro"] 
#     provided within []
#     list(string)
#     list(map(string))

#     bool/boolean = true / false

#     map = { Name = "anil", Surname = "gencdogus" }
#     provided within {}
#     map(string)
#     map(list(string))

#     number only numeric chars and don't need to be in quotes or brackets

 variable "my_name_is_anil" {
   type = bool
   default = true #/ false
 }

variable "my_age" {
  type = number
  default = 32
}

variable "tags" {
  type = map(string)
  default = {
    Name = "anil"
    Surname = "gencdogus"
  }
}


# var.prefix it returns a value of "dev"
variable "prefix" { # Input variables
  default = "dev" # = string 
}

# var.instance_type it returns a value of "t2.micro"
variable "instance_type" { # Input variables
  default = "t2.micro" # = string
  type = string
}
# aws_instance.server.ami = "ami-0f9de6e2d2f067fca"
# aws_instance.server.ami = local.image_id
# local.image_id = "ami-0f9de6e2d2f067fca" 
# local.image_id = data.aws_ami.ubuntu.id
# data.aws_ami.ubuntu.id = "ami-0f9de6e2d2f067fca"

resource "aws_instance" "server" {
  ami           = local.image_id #= data.aws_ami.ubuntu.id = "ami-0f9de6e2d2f067fca"
  instance_type = var.instance_type

  tags = var.tags
}

output "ubuntu_image_id" {
  value = local.image_id
}
output "vpc_security_group_ids" {
  value = aws_instance.server.vpc_security_group_ids
}


# my_family:
#   mom_and_dad:
#     children_1:
#       name:
#       age:
#       occupation:
#     children_2:
#       name:
#       age:
#       occupation:
#     children_3:
#       name:
#       age:
#       occupation:
#     children_4:
#       name:
#       age:
#       occupation:



## Object Oriented Language
# pizza:
#    size: 12"
#     white_sauce:
#       pepperoni:
#     red_sauce:
#       mushroom:
#       pepperoni:

# yaml
# json

