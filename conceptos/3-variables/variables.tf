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
    nullable    = false # true
                       # Indica si se le puede asignar un valor null
                       # Si no le pongo valor, se considera que tiene valor null? NOMBRE
                       # No es lo mismo una variable desasignada que asignada a null
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
                  }))
    nullable    = false # true
                       # Indica si se le puede asignar un valor null
                       # Si no le pongo valor, se considera que tiene valor null? NOMBRE
                       # No es lo mismo una variable desasignada que asignada a null
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