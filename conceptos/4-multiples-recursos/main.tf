
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

    count = var.numero_de_contenedores          # Quiero tantas copias de este recurso
    # Al usar un cont, disponemos de la variable cont.index, 
    # que se irá incrementando para cada recurso que se cree
    name        = "minginx_${count.index}"
    image       = docker_image.imagen.image_id
    
    ports {
        internal = 80
        external = 8080 + count.index
    }
}

resource "docker_container" "balanceador" {

    count = var.crear_balanceador ? 1 : 0
    # El count aplicado a un recurso, me permite tanto implementar bucles, 
    # como condicionales
    name        = "balanceador"
    image       = docker_image.imagen.image_id
    
    ports {
        internal = 80
        external = 81
    }
}

resource "docker_image" "imagen" {
    name = "nginx:latest"  
}
