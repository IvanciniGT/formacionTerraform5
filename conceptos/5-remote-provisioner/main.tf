terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
        }
    }
}

provider "docker" {
}

resource "docker_container" "contenedor" {
    name        = "localnginx_${count.index}"
    image       = docker_image.imagen.image_id
}

resource "docker_image" "imagen" {
    name = "nginx:latest"  
}
