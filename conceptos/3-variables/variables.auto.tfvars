nombre_contenedor    = "minginx"
repo_imagen          = "nginx"
tag_imagen           = "latest"
cuota_cpu            = 2048
variables_entorno =  [
                            {
                                "clave" = "VAR1"
                                "valor" = "valor1"
                            },
                            {
                                "clave" = "VAR2"
                                "valor" = "valor2"
                            },
                            {
                                "clave" = "VAR3"
                                "valor" = "valor4"
                            }
                        ]
puertos_a_exponer    =  [
                            {
                                "interno" = 80
                                "externo" = 8080 
                            },
                            {
                                "interno" = 443
                                "externo" = 8443 
                            }
                        ]
