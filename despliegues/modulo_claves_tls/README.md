module "misclaves" {
    source = "..."
    algoritmo = ""              # String
    configuracion = ""          # String
    force_recreate = boolean
        Si false, 
            comprueba si ya existen los ficheros...
                Y los carga
                Y su contenido es lo que asigna en los outputs
        Si no existen los ficheros o la variable está en true,
            Se generan nuevas claves 
                Si file destination no es nulo, se vuelcan a ficheros
            Y se meten en los outputs
    file_destination = ""       # String (path) OPCIONAL
                                    publicKey.pem
                                    privateKey.pem
                                    publicKey.openssh
                                    privateKey.openssh
}

Va a generar 2 outputs
    privateKey -> Map ( openSSH pem)
    publicKey  -> Map ( openSSH pem)
Y opcionalmente 2 ficheros

Clave Publica y Privada