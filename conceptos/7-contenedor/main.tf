# Aquí escribimos sintaxis HCL

# COMENTARIOS: con el cuadradito !

# Objetivo
#
# Crear un contenedor con NGINX
# Para ello además necesitaremos la IMEGEN DEL CONTENEDOR
# Y todo ello lo pediremos a un PROVEEDOR

terraform {
    required_providers {
        # Los proveedores los buscamos en el registry de terraform .
        docker = {
              source = "kreuzwerker/docker"
              #version = "2.23.0"
        }
    }
}


         # TIPO DE RECURSO  # ID/NOMBRE del recurso dentro del script
resource "docker_container" "contenedor" {
    name        = var.nombre_contenedor
    image       = docker_image.imagen.image_id
                  # Variable          # Propiedad de esa variable
    #start       = false
    
    cpu_shares  = var.cuota_cpu # Le dejo usar el equivalente a un core.
                  # Y si no quiero limitarle la cpu ? 
    # Cuando en terraform, a una propiedad de un recurso le asignamos valor null
    # Es como si no hubiera escrito la propiedad
                  
    # Espera un set(string)
    env         = [ for variable in var.variables_entorno: "${variable.clave}=${variable.valor}" ]
                    # bucles en linea de python
    # Los bloks no llevan igual 
    #ports         {.  SOLUCION DE MIERDA 1
                    #internal = var.puerto_http[0]
                    #external = var.puerto_http[1]
    #              }
    #ports         {  #SOLUCION DE MIERDA 2 y 3
    #                internal = var.puerto_http.interno
    #                external = var.puerto_http.externo
    #              }
    
    # Atención: DYNAMIC SOLO SIRVE PARA BLOQUES DINAMICOS.
    # Más adelante habrá otras cosas que queramos montar en bucle
    dynamic "ports"{
        for_each = var.puertos_a_exponer
                   # Un for_each en un dynamic recibe una lista
        iterator = puerto
        content {
                    internal = puerto.value["interno"]
                    external = puerto.value["externo"]
                    ip       = puerto.value["ip"]
                }
    }
    # Quiero también el puerto 8443 -> 443
}

# Aquí digo que quiero esa imagen de contenedor
resource "docker_image" "imagen" {
    name = "${var.repo_imagen}:${var.tag_imagen}"              # Docker hub
          # Interpolacion de variables
}
            #nginx: REPO
            #latest: tag < IMAGEN
            
# Terraform en automático hace un árbol de dependencias entre los recursos... Y los crea en consecuencia a ese árbol.