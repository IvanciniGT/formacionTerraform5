
variable "numero_de_contenedores" {
    type = number
    description = "Número de contenedores a crear"
    default = 3
    nullable = false
    # Aqui habria que validar
}

# Qué tal veis esta solución? Para este caso ha funcionado-
#                             LIMITADO en cuanto a lo que pòdemos hacer
#                             SENCILLO !

variable "crear_balanceador" {
    type = bool
    description = "Crear balanceador?"
    default = true
    nullable = false
}


variable "contenedores_a_crear" {
    type = map(number)
    description = "Contenedores a crear"
    default = {
                "contenedor1" = 9990
                "contenedorB" = 9999
               }  
    nullable = false
}

variable "contenedores_a_crear_mas_personalizados" {
    type = map(object({
        puerto_interno = number
        puerto_externo = number
        variables_entorno = set(string)
    }))
    description = "Contenedores a crear"
    default = {
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
    nullable = false
}
