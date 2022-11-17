terraform {
    required_providers {
        docker = {
              source = "kreuzwerker/docker"
        }
    }
}

provider "docker" {
# Configuración de los providers
}

module "contenedor" {
    source = "../7-contenedor"
    nombre_contenedor    = var.container_name_de_mi_script
    repo_imagen          = "httpd"
    cuota_cpu            = null
    tag_imagen           = var.tag_image_de_mi_script
    variables_entorno    =  [ ]
    puertos_a_exponer    =  [
                                {
                                    "interno" = 80
                                    "externo" = 8080 
                                    "ip"      = "127.0.0.1"
                                }
                            ]
}

module "balanceador" {
    source = "../7-contenedor"
    nombre_contenedor    = "balanceador1"
    repo_imagen          = "nginx"
    cuota_cpu            = null
    tag_imagen           = var.tag_image_de_mi_script
    variables_entorno    =  [ ]
    puertos_a_exponer    =  [
                                {
                                    "interno" = 80
                                    "externo" = 8081 
                                    "ip"      = "127.0.0.1"
                                }
                            ]
}

output "ip_balanceador" {
    value = module.balanceador.direccion_ip
}