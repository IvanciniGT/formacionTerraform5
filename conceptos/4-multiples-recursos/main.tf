
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

            # EL COUNT obliga a pasar un numero
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

resource "docker_container" "contenedores_personalizados" {
    # Los for_each dentro de un resource PUEDEN recibir un MAP
    for_each = var.contenedores_a_crear
    # Al usar un for_each, tengo acceso a la variable:
    # each.key      Me da la clave de cada elemento
    # each.value    Me da el valor asociado a cada clave

    name        = each.key
    image       = docker_image.imagen.image_id
    
    ports {
        internal = 80
        external = each.value
    }
}
####


resource "docker_container" "contenedores_mas_personalizados" {

    # Los for_each dentro de un resource PUEDEN RECIBIR:
    # O bien un mapa
    # O bien un set(string)
    for_each = var.contenedores_a_crear_mas_personalizados
    # Al usar un for_each, tengo acceso a la variable:
    # each.key      Me da la clave de cada elemento
    # each.value    Me da el valor asociado a cada clave

    name        = each.key
    image       = docker_image.imagen.image_id
    
    ports {
        internal = each.value.puerto_interno
        external = each.value.puerto_externo
    }

    env = each.value.variables_entorno
}


resource "docker_container" "contenedores_mas_personalizados_2" {
    count = length(var.contenedores_a_crear_mas_personalizados_2)
    # Al usar un for_each, tengo acceso a la variable:
    # each.key      Me da la clave de cada elemento
    # each.value    Me da el valor asociado a cada clave

    name        = var.contenedores_a_crear_mas_personalizados_2[count.index].nombre
    image       = docker_image.imagen.image_id
    
    ports {
        internal = var.contenedores_a_crear_mas_personalizados_2[count.index].puerto_interno
        external = var.contenedores_a_crear_mas_personalizados_2[count.index].puerto_externo
    }

    env = var.contenedores_a_crear_mas_personalizados_2[count.index].variables_entorno
}



resource "docker_image" "imagen" {
    name = "nginx:latest"  
}
