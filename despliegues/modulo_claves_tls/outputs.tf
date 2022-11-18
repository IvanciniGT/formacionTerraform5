
output "privateKey" {
    value = length( tls_private_key.claves ) == 1 ? {
                    pem      = tls_private_key.claves[0].private_key_pem
                    open_ssh = tls_private_key.claves[0].private_key_openssh
                } : {
                    pem      = local.contendo_fichero_clave_privada_pem
                    open_ssh = local.contendo_fichero_clave_privada_open_ssh
                }
}

output "publicKey" {
    value = length( tls_private_key.claves ) == 1 ? {
                    pem      = tls_private_key.claves[0].public_key_pem
                    open_ssh = tls_private_key.claves[0].public_key_openssh
                } : {
                    pem      = local.contendo_fichero_clave_publica_pem
                    open_ssh = local.contendo_fichero_clave_publica_open_ssh
                }
}
