# Nombre del contenedor
variable "nombre_contenedor" {
    description = "Nombre del contenedor a generar"
    type        = string # string | bool | number | list() | set() | object() | map () | any
    #default     = "" # En los scripts... RARO ! NUNCA !
                     # Más adelante, cuando veamos los módulos, veremos que ahí si
    nullable    = false # true
                       # Indica si se le puede asignar un valor null
                       # Si no le pongo valor, se considera que tiene valor null? NOMBRE
                       # No es lo mismo una variable desasignada que asignada a null
    validation {
        condition     = length(regexall("^[a-z][a-z0-9]{5,20}$", var.nombre_contenedor))==1
        error_message = "El nombre de contenedor no es válido"
    }
}

# Imagen
variable "repo_imagen" {
    description = "Nombre del repo de la imagen del contenedor"
    type        = string # string | bool | number | list() | set() | object() | map () | any
    #default     = "" # En los scripts... RARO ! NUNCA !
                     # Más adelante, cuando veamos los módulos, veremos que ahí si
    nullable    = false # true
                       # Indica si se le puede asignar un valor null
                       # Si no le pongo valor, se considera que tiene valor null? NOMBRE
                       # No es lo mismo una variable desasignada que asignada a null
}
variable "tag_imagen" {
    description = "Tag de la imagen del contenedor"
    type        = string # string | bool | number | list() | set() | object() | map () | any
    #default     = "" # En los scripts... RARO ! NUNCA !
                     # Más adelante, cuando veamos los módulos, veremos que ahí si
    nullable    = false # true
                       # Indica si se le puede asignar un valor null
                       # Si no le pongo valor, se considera que tiene valor null? NOMBRE
                       # No es lo mismo una variable desasignada que asignada a null
}
# Cuota_CPU
variable "cuota_cpu" {
    description = "Cuota de CPU para el contenedor"
    type        = number # string | bool | number | list() | set() | object() | map () | any
    #default     = "" # En los scripts... RARO ! NUNCA !
                     # Más adelante, cuando veamos los módulos, veremos que ahí si
    nullable    = true
                       # Indica si se le puede asignar un valor null
                       # Si no le pongo valor, se considera que tiene valor null? NOMBRE
                       # No es lo mismo una variable desasignada que asignada a null
    validation {
                    # Condicional en linea, operador ternario 
                    # condicion ? valor si true : valor si false
        condition = var.cuota_cpu == null ? true : var.cuota_cpu > 0 # Expresion lógica que si true, indica que el valor es bueno
        error_message = "El valor de cuota de cpu debe ser mayor que cero" # Que se muestra si el valor no es bueno
    }        
    validation {
        condition = var.cuota_cpu == null ? true : var.cuota_cpu <= 2048 # Expresion lógica que si true, indica que el valor es bueno
        error_message = "El valor de cuota de cpu debe ser menor o igual a 2048" # Que se muestra si el valor no es bueno
    }                       
}

# Puertos
# variable "puerto_http" {
#    description = "Puertos a exponer para el contenedor"
#    type        = list(number) # string | bool | number | list() | set() | object() | map () | any
#    #default     = "" # En los scripts... RARO ! NUNCA !
#                     # Más adelante, cuando veamos los módulos, veremos que ahí si
#    nullable    = false # true
#                       # Indica si se le puede asignar un valor null
#                       # Si no le pongo valor, se considera que tiene valor null? NOMBRE
#                       # No es lo mismo una variable desasignada que asignada a null
#}
# SOLUCION DE MIERDA 1 !!!!!!!! NO ES EXPLICITO !!!!!

#variable "puerto_http" {
#    description = "Puertos a exponer para el contenedor"
#    type        = map(number) 
#    nullable    = false # true
                       # Indica si se le puede asignar un valor null
                       # Si no le pongo valor, se considera que tiene valor null? NOMBRE
                       # No es lo mismo una variable desasignada que asignada a null
#}
# SOLUCION DE MIERDA 2 !!!!!!!!  Tengo control sobre las claves que pueden usar? Ninguno

#variable "puerto_http" {
#    description = "Puertos a exponer para el contenedor"
#    type        = object({
#                    interno = number
#                    externo = number
#                  })
#    nullable    = false # true
                       # Indica si se le puede asignar un valor null
                       # Si no le pongo valor, se considera que tiene valor null? NOMBRE
                       # No es lo mismo una variable desasignada que asignada a null
#}
# SOLUCION DE MIERDA 3. Aquí si tengo control de los datos
# Y si ahora quiero abrir más puertos? Hoy 3, mañana 5


variable "puertos_a_exponer" {
    description = "Puertos a exponer para el contenedor"
    type        = list(object({
                    interno = number
                    externo = number
                    ip      = optional(string, "0.0.0.0")
                  }))
    nullable    = false # true
                       # Indica si se le puede asignar un valor null
                       # Si no le pongo valor, se considera que tiene valor null? NOMBRE
                       # No es lo mismo una variable desasignada que asignada a null

    validation {
        condition = alltrue(
                        [ for puerto in var.puertos_a_exponer: puerto.interno < 65000 ] #list(bool)
                    ) 
        error_message = "El puerto interno debe ser menor que 65000"
    }     
    
    validation {
        condition = alltrue(
                        [ for puerto in var.puertos_a_exponer: puerto.externo < 65000 ] #list(bool)
                    ) 
        error_message = "El puerto externo debe ser menor que 65000"
    }     
    
    validation {
        condition = alltrue(
                        [ for puerto in var.puertos_a_exponer: 
                            length(regexall("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]?|0)[.]){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]?|0)$", puerto.ip))==1
                        ] #list(bool)
                    ) 
        error_message = "La IP no es válida"
    }     
    
    # Expresiones regulares! 
}




variable "variables_entorno" {
    description = "Variables de entorno del contenedor"
    type        = set(object({
                        clave = string
                        valor = string
                  }))
    nullable    = false # true
                       # Indica si se le puede asignar un valor null
                       # Si no le pongo valor, se considera que tiene valor null? NOMBRE
                       # No es lo mismo una variable desasignada que asignada a null
} 
# SOLUCION DE MIERDA !!!!!! EXPLICITO       ? NO     set(string)
# SOLUCION DE MENOS MIERDA !!!!!! EXPLICITO ? NO     map(string)