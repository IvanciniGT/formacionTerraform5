
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
    
    # Cuando se ejecuta ese provisionador?
    # Cuando se crea o modifica el recurso... pero tenemos varios quí dentro?
    # hacia eso para cada uno de ellos
    
    # El fichero en seguida se nos queda fatal.. corrupto.
    # Al borrar, no se borran entradas
    # Al modificadr, quedan duplicadas.
    
    provisioner "local-exec" {
        command = "echo '${self.network_data[0].ip_address}' >> inventario.ini"
        # docker_container.contenedor = self
    } 
}

resource "docker_image" "imagen" {
    name = "nginx:latest"  
}
