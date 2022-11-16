# Esto me permitirá a posteriori sacar la ip del contenedor de forma sencilla,
# Sin necesidad de andar metiendome en el JSON, COSA QUE NO QUERRIA HACER NUNCA JAMAS EN LA VIDA !

output "direccion_ip_contenedores" {
    #value = docker_container.contenedor.ip_address
    value = [ for contenedor in docker_container.contenedor:
                contenedor.network_data[0].ip_address ]
}

output "direccion_ip_contenedores_aplanados" {
    #value = docker_container.contenedor.ip_address
    value = join(";",[ for contenedor in docker_container.contenedor:
                contenedor.network_data[0].ip_address ])
}
 
# Esta información a posteriori la recupero mediante el comando:
#  $ terraform output (--json |--raw) NOMBRE

# Queremos las ips de los contenedores_personalizados


output "direccion_ip_contenedores_personalizados" {
    #value = docker_container.contenedor.ip_address
    value = { for nombre,contenedor in docker_container.contenedores_personalizados:
                nombre => contenedor.network_data[0].ip_address }
}

output "direccion_ip_contenedores_personalizados_aplanados" {
    #value = docker_container.contenedor.ip_address
    value = join("\n",[ for nombre,contenedor in docker_container.contenedores_personalizados:
                "${nombre}=${contenedor.network_data[0].ip_address}" ])
}