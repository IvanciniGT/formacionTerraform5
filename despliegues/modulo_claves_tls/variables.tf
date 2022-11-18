variable "algoritmo" {
    description = "Algoritmo a utilizar para las claves"
    type        = object({
                        nombre        = string
                        configuracion = optional(string, null)
                    })
    nullable    = false 
    default     = {
                    nombre = "RSA"
                    configuracion = 2048
                  }
    validation {
        condition     = contains( ["RSA", "ECDSA", "ED25519"], upper(var.algoritmo.nombre) )
        error_message = "El algoritmo no es válido"
    }
    
    validation {
        condition     = ( 
                            upper(var.algoritmo.nombre) != "RSA" 
                                ? true 
                                : (can(tonumber(var.algoritmo.configuracion)) 
                                    ? tonumber(var.algoritmo.configuracion) > 0 
                                    : false )
                        )
        error_message = "La configuración no es válida para el algoritmo RSA. Debe indicar un número mayor que 0"
    }
    
    validation {
        condition     = ( 
                            upper(var.algoritmo.nombre) != "ED25519" 
                                ? true 
                                : var.algoritmo.configuracion == null 
                        )
        error_message = "La configuración no es válida para el algoritmo ED25519. Debe dejarse sin asignar"
    }
    
    validation {
        condition     = (
                            upper(var.algoritmo.nombre) != "ECDSA" 
                                ? true 
                                : contains( ["P224","P256", "P384", "P521"], upper(var.algoritmo.configuracion) )
                        )
        error_message = "La configuración no es válida para el algoritmo ECDSA. Debe indicar un valor entre: P224, P256, P384, P521"
    }
}

variable "force_recreate" {
    description = "Regenerar claves incluso si existen"
    type        = bool
    nullable    = false 
    default     = true
}

variable "file_destination" {
    description = "Directorio donde generar los ficheros"
    type        = string 
    nullable    = false
    default     = "."
    validation {
        condition     = length(regexall("^[.]?[\\/]?([a-zA-Z0-9_-]+[\\/]?)*$", var.file_destination))==1
        error_message = "El directorio no es válido"
    }
}