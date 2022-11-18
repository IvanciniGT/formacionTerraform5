terraform {
    required_providers {
        aws = {
              source = "hashicorp/aws"
              version = "~> 4.0"
        }
        null = {
              source = "hashicorp/null"
        }
    }
}

provider "aws" {
    region = "eu-west-1"
}
provider "null" {
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

    ami                 = data.aws_ami.mi_imagen.id
    instance_type       = "t2.micro"
    
    key_name            = aws_key_pair.claves_en_amazon.id # Pero ni coña pongo aquí "ClavePublicaIvan"
                                                           # Garantizar el orden.. y que el key_pair se ejecute antes. 
    
    security_groups     = [ aws_security_group.permitir_trafico_ssh_y_salida.name ]
    
    tags = {
        Name            = "Maquina de Ivan"
    }
    
}

resource "null_resource" "smoke_test_maquina"{
    count = var.quieres_probar ? 1 : 0

    triggers = {
        forzar_ejecucion = timestamp()  # Quiero que el test se haga SIEMPRE QUE EJECUTO EL SCRIPT
    }

    connection {
        type            = "ssh"
        host            = aws_instance.mi_maquina.public_ip
        port            = 22
        user            = "ubuntu"
        private_key     = module.mis_claves.privateKey.pem
    }
    
    provisioner "remote-exec" { 
        inline          = [ "echo Dentro de la máquina. EUREKA." ]
    }
    
}

variable "quieres_probar" {
    type = bool
    default = false
}

resource "aws_key_pair" "claves_en_amazon" {
    key_name   = "ClavePublicaIvan"
    public_key = module.mis_claves.publicKey.open_ssh # Nos generamos nuestra clave publica OPENSSH
}

module "mis_claves" {
    source              ="../modulo_claves_tls"
    algoritmo           = {
                            nombre        = "RSA"
                            configuracion = "4096"
                          }
    force_recreate      = false
    file_destination    = "clavesIvan"
}


resource "aws_security_group" "permitir_trafico_ssh_y_salida" {
  name        = "permitir_ssh_ivan"
  description = "Permitir SSH y Salida"
  vpc_id      = null

  ingress {
    description      = "Permitir ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "permitir_ssh_ivan"
  }
}

# 1- Crear una clave privada / publica tls
# 2- Enchufar el fichero de la clave publica en el servidor ----> AMAZON
# 3- Usaré la clave privada para conectarme con mi servidor y ver que funciona.... SMOKE TEST !!!!
