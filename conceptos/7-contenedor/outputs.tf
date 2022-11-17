# Esto me permitirá a posteriori sacar la ip del contenedor de forma sencilla,
# Sin necesidad de andar metiendome en el JSON, COSA QUE NO QUERRIA HACER NUNCA JAMAS EN LA VIDA !

output "direccion_ip" {
    #value = docker_container.contenedor.ip_address
    value = docker_container.contenedor.network_data[0].ip_address
}

# Esta información a posteriori la recupero mediante el comando:
#  $ terraform output (--json |--raw) NOMBRE

