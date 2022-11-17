terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
        }
    }
}

provider "docker" {
# Configuración !!!!!!!
}

resource "docker_container" "contenedor" {
    name        = "remote_container"
    image       = docker_image.imagen.image_id
    
    connection {
        type        = "ssh" # winrm
        host        = self.network_data[0].ip_address
        port        = "22"
        user        = "root"
        password    = "root"
    }
    
    provisioner "remote-exec" {
        inline = [ "echo DENTRO DEL CONTENEDOR" , "echo EUREKA > /tmp/registro.exito" ]   
    }
    
    provisioner "remote-exec" {
        script = "./script-en-entorno-terraform.sh"
        #scripts = ["script1", "script2"]
    }
    
    provisioner "file" {
        content     = "Soy un contenido autogenerado dentro del contenedor: ${self.name}"
        destination = "/tmp/archivo1.txt"
    }
    
    provisioner "file" {
        source      = "./ficheroParaEnviar.txt"
        destination = "/tmp/archivo2.txt"
    }
}

resource "docker_image" "imagen" {
    name = "rastasheep/ubuntu-sshd:latest"  
}
