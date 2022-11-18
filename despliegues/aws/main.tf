terraform {
    required_providers {
        aws = {
              source = "hashicorp/aws"
              version = "~> 4.0"
        }
    }
}

provider "aws" {
    region = "eu-west-1"
}


# 099720109477
# ubuntu-xenial-16.04-amd64-server
# Ultima
# Hypervisor vendor:   KVM
# El data me permite hacer una búsqueda en el proveedor

data "aws_ami" "mi_imagen" {
    most_recent      = true
    owners           = ["099720109477"]
    
    filter {
        name   = "name"
        values = ["*ubuntu-xenial-16.04-amd64-server-*"]
    }
    
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

resource "aws_instance" "mi_maquina"{
    ami             = data.aws_ami.mi_imagen.id
    instance_type   = "t2.micro"
    tags = {
        Name = "Maquina de Ivan"
    }
}

