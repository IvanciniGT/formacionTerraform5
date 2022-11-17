output "direccion_ip" {
    value = docker_container.contenedor.network_data[0].ip_address
}
