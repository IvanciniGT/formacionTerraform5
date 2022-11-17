# Nombre del contenedor
variable "container_name_de_mi_script" {
    description = "Nombre del contenedor a generar"
    type        = string 
    nullable    = false
    validation {
        condition     = length(regexall("^[a-z][a-z0-9]{5,20}$", var.container_name_de_mi_script))==1
        error_message = "El nombre de contenedor no es válido"
    }
}

variable "tag_image_de_mi_script" {
    description = "Tag de la imagen del contenedor"
    type        = string 
    nullable    = false
}