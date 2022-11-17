# Variables

null -> Que pasa cuando asignamos null a una propiedad de un recurso?
        Es como si no hubieramos definido la propiedad.
    
# Creación de múltiples Recursos

resource TIPO NOMBRE {
    count = < NUMERO DE RECURSOS A CREAR >

    # Al usar el count, que variable teniamos a nuestra disposición?
    # count.index
}

Al usar count, y referirnos posteriormente a TIPO.NOMBRE, que se nos devuelve?
Lista de objetos de tipo: TIPO

resource TIPO NOMBRE {
    for_each = < MAP | SET(string) >
                -----
    
    # Al usar el for_each, que variable tenemos a nuestra disposición?
        # each.key
        # each.value
}

Al usar for_each, y referirnos posteriormente a TIPO.NOMBRE, que se nos devuelve?
Mapa de Objetos de tipo: TIPO, cuyas claves las mismas que las del 
mapa que suministro al for_each


# Aprovisionadores: Provisioners

Acciones que puedo ejecutar durante :
- La crearión, modificación de un recurso
- La eliminación de un recurso

3 tipos de provisionadores:
- local-exec        Nos permite ejecutar un comando en el mismo entorno
                    donde ejecutamos terraform  
- remote-exec       Nos permite ejecuatr un comando en el recurso 
                    donde está definido
- file              Nos permite copiar o crear archivos en el recurso en 
                    el que está definido




























