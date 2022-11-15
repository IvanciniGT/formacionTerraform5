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

provider "docker" {
    # Configuración adicional del proveedor. En este caso no necesitamos.
}

         # TIPO DE RECURSO  # ID/NOMBRE del recurso dentro del script
resource "docker_container" "contenedor" {
    name        = "minginx2"
    image       = docker_image.imagen.image_id
                  # Variable          # Propiedad de esa variable
    #start       = false
    cpu_shares  = 1024 # Le dejo usar el equivalente a un core.
    env         = [
                    "VAR1=valor1",
                    "VAR2=valor2"
                  ]
    # Los bloks no llevan igual 
    ports         {
                    internal = 80
                    external = 8080
                  }
    ports         {
                    internal = 443
                    external = 8443
                  }
    # Quiero también el puerto 8443 -> 443
}

# Aquí digo que quiero esa imagen de contenedor
resource "docker_image" "imagen" {
    name = "nginx:latest"               # Docker hub
}
            #nginx: REPO
            #latest: tag < IMAGEN
            
# Terraform en automático hace un árbol de dependencias entre los recursos... Y los crea en consecuencia a ese árbol.