contenedores_a_crear_mas_personalizados = {
                                                "contenedor_P1" = {
                                                                puerto_interno = 80
                                                                puerto_externo = 9980
                                                                variables_entorno = []
                                                              }
                                                "contenedor_P2" = {
                                                                puerto_interno = 443
                                                                puerto_externo = 9989
                                                                variables_entorno = ["VARIABLE1=VALOR1"]
                                                               }
                                           }
                                           
contenedores_a_crear_mas_personalizados_2 = [
                                                {
                                                    nombre = "contenedor_P_2_1"
                                                    puerto_interno = 80
                                                    puerto_externo = 9880
                                                    variables_entorno = []
                                                },
                                                {
                                                    nombre = "contenedor_P_2_2"
                                                    puerto_interno = 443
                                                    puerto_externo = 9889
                                                    variables_entorno = ["VARIABLE1=VALOR1"]
                                                }
                                           ] 