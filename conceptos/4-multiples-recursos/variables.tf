
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