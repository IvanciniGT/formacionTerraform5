
locals {
    directorio_ficheros = endswith(var.file_destination,"/") ? var.file_destination : "${var.file_destination}/"
                         # Lleva barra al final              ? Pues lo dejo como está    Que no? Se la pongo

    existe_fichero_clave_privada_pem        = fileexists( "${locals.directorio_ficheros}privateKey.pem" )
    existe_fichero_clave_privada_open_ssh   = fileexists( "${locals.directorio_ficheros}privateKey.openssh" ) 
    existe_fichero_clave_publica_pem        = fileexists( "${locals.directorio_ficheros}publicKey.pem" ) 
    existe_fichero_clave_publica_open_ssh   = fileexists( "${locals.directorio_ficheros}publicKey.openssh" ) 
    
    existen_todos_los_ficheros_claves       = ( existe_fichero_clave_privada_pem        &&
                                                existe_fichero_clave_privada_open_ssh   &&
                                                existe_fichero_clave_publica_pem        &&
                                                existe_fichero_clave_publica_open_ssh )
                                                
    contendo_fichero_clave_privada_pem      = existe_fichero_clave_privada_pem ? file( "${locals.directorio_ficheros}privateKey.pem" )      : null
    contendo_fichero_clave_privada_open_ssh = existe_fichero_clave_privada_pem ? file( "${locals.directorio_ficheros}privateKey.openssh" )  : null
    contendo_fichero_clave_publica_pem      = existe_fichero_clave_privada_pem ? file( "${locals.directorio_ficheros}publicKey.pem" )       : null
    contendo_fichero_clave_publica_open_ssh = existe_fichero_clave_privada_pem ? file( "${locals.directorio_ficheros}publicKey.openssh" )   : null
}

# Esto lo estariamos generando siempre.... no se si es lo que queremos.
resource "tls_private_key" "claves" {
    # Me permitira generar o no el recurso: 0 o 1
    count       = locals.existen_todos_los_ficheros_claves && ! force_recreate ? 0 : 1
                  # Si existen ficheros anteriores de claves y no se fuerza el recreado

    algorithm   = var.algoritmo.nombre
    ecdsa_curve = var.algoritmo.nombre == "ECDSA" ? var.algoritmo.configuracion : null
    rsa_bits    = var.algoritmo.nombre == "RSA"   ? var.algoritmo.configuracion : null
    
    provisioner "local-exec" {
        command = <<EOT
                        mkdir -p ${locals.directorio_ficheros}
                        echo '${self.private_key_pem}'       > "${locals.directorio_ficheros}privateKey.pem"
                        echo '${self.private_key_openssh}'   > "${locals.directorio_ficheros}privateKey.openssh"
                        echo '${self.public_key_pem}'        > "${locals.directorio_ficheros}publicKey.pem"
                        echo '${self.public_key_openssh}'    > "${locals.directorio_ficheros}publicKey.openssh"
                    EOT
    }
}
