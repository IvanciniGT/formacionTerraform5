terraform {
    required_providers {
        tls = {
              source = "hashicorp/tls"
        }
    }
}

provider "tls" {
    
}

module "claves_prueba" {
    modulo_claves_tls   = {
                            nombre        = "RSA"
                            configuracion = "2048"
                          }
                    

    force_recreate      = true

    file_destination    = "claves"
}