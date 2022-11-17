
terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
        }
        null = {
            source = "hashicorp/null"
        }
    }
}

provider "docker" {
}
provider "null" {
}
# 2º El SEGUNDO QUE CAE
resource "docker_container" "contenedor" {
    # Este case el segundo.. YA QUE habiendo ejecutado el primero, sus dependencias YA ESTAN RESUELTAS !
    count       = 5
    name        = "localnginx_${count.index}"
    image       = docker_image.imagen.image_id
    
    provisioner "local-exec" { # SMOKE TEST. Una prueba de apretar el botón y ver si aquello funciona !
        command = "curl http://${self.network_data[0].ip_address}:80"
    } 
    
    provisioner "local-exec" {
        command = "echo CHAO PESCAO !"
        when = destroy
    } 
}

# ESTE ENTRA EL TERCERO 
resource "null_resource" "generar_fichero_ips" {

    # Cuando queremos que se ejecute este comando? Cada vez que cambie la lista de ips 
    # Con respecto a la ejecución anterior!
    triggers = {
        listado_de_ips = join("|",[ for contenedor in docker_container.contenedor: contenedor.network_data[0].ip_address ])
    }
    
    # Cuántas veces se ejecutará esto por cada vez que ejecuto el script?  Como mucho 1
    provisioner "local-exec" {
        # Extrae todas las ips de los contenedors, las pone una detras de otra, separadas por saltos de linea, y las mete en un fichero nuevo.
        command = <<EOT
                        mkdir -p inventarios
                        echo "$LISTADO_IPS" > inventarios/inventario.ini
                    EOT
        interpreter = ["/bin/bash","-c"] # sh, bash, cmd, python, perl
        environment = {
            LISTADO_IPS = join( "\n", [ for contenedor in docker_container.contenedor: contenedor.network_data[0].ip_address ] )
        }
        on_failure = continue          #fail(por defecto)
    } 
}

# 1º que se crea... ya que NO DEPENDE DE NADIE !
resource "docker_image" "imagen" {
    # Aqui dentro hay alguna variable que apunte a otro lao??? NO => Libre de dependencias! EL PRIMERO EN CAER !
    name = "nginx:latest"  
}
