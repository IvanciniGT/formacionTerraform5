
locals {
    directorio_ficheros = var.file_destination # Le añadiré una barra al final, si no la tiene

    existe_fichero_clave_privada_pem        = true
    existe_fichero_clave_privada_open_ssh   = false
    existe_fichero_clave_publica_pem        = 
    existe_fichero_clave_publica_open_ssh   = 
    
    contendo_fichero_clave_privada_pem      = "texto"
    contendo_fichero_clave_privada_open_ssh = 
    contendo_fichero_clave_publica_pem      = 
    contendo_fichero_clave_publica_open_ssh = 
    
    
    existen_todos_los_ficheros_claves       =   existe_fichero_clave_privada_pem        &&
                                                existe_fichero_clave_privada_open_ssh   &&
                                                existe_fichero_clave_publica_pem        &&
                                                existe_fichero_clave_publica_open_ssh
}

# Esto lo estariamos generando siempre.... no se si es lo que queremos.
resource "tls_private_key" "claves" {
    # Me permitira generar o no el recurso: 0 o 1
    count       = locals.existen_todos_los_ficheros_claves && ! force_recreate ? 0 : 1
                  # Si existen ficheros anteriores de claves y no se feurza el recreado

    algorithm   = var.algoritmo.nombre
    ecdsa_curve = var.algoritmo.nombre == "ECDSA" ? var.algoritmo.configuracion : null
    rsa_bits    = var.algoritmo.nombre == "RSA"   ? var.algoritmo.configuracion : null
    
    provisioner "local-exec" {
        command = <<EOT
                        mkdir -p ${locals.directorio_ficheros}
                        echo '${self.private_key_pem}'       > ${locals.directorio_ficheros}privateKey.pem
                        echo '${self.private_key_openssh}'   > ${locals.directorio_ficheros}privateKey.openssh
                        echo '${self.public_key_pem}'        > ${locals.directorio_ficheros}publicKey.pem
                        echo '${self.public_key_openssh}'    > ${locals.directorio_ficheros}privateKey.openssh
                    EOT
    }
}
