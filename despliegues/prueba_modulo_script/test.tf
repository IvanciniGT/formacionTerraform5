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
    source              ="../modulo_claves_tls"
    
    algoritmo           = {
                            nombre        = "RSA"
                            configuracion = "2048"
                          }
                    

    force_recreate      = true

    file_destination    = "claves"
}