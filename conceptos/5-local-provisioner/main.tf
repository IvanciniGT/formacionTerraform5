
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
    count       = 2
    name        = "localnginx_${count.index}"
    image       = docker_image.imagen.image_id
    
    provisioner "local-exec" {
        command = "echo '${self.network_data[0].ip_address}' >> inventario.ini"
        # docker_container.contenedor = self
    }
}

resource "docker_image" "imagen" {
    name = "nginx:latest"  
}
