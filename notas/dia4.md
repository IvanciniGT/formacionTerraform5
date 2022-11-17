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

# Cuantas veces se ejecuta un provisionador? 

Tantas como recursos se entén creando dentro de un bloque resource: 
- count
- for_each

Y si no hay count ni for_each: 1






# Modulos

Script python, bash, ps1

El script irá en su lenguaje... normalmente usando un paradigma imperativo en la mayor parte....

Rutinas, Metodos, Funciones, Procedimiento, MODULOS
    Cuando la llamo, envirle argumentos, parámetros, variables
    Y cuando la funcion acaba puede que devuelva algo... (return) .... outputs

Un modulo no es sino:
Un conjunto de recursos (con sus provisionadores), outputs, variables, datas, proveedores (sin su configuración); reutilizable

Qué es un script de terraform ?
Un conjunto de recursos (con sus provisionadores), outputs, variables, datas, proveedores (+ con su configuración)

Script:
    ->  Modulos
                -> Recursos











def doblar(numero=1):
    # Validar el valor que entra en numero
    return numero*2




numeros=os.env["numeros"]
# validar el valor de numero
for item in numeros:
    doblar(numero=item)





Maquina AWS

Elegir la imagen ... Parto la burra !!!
Instancia
Tipo
Credenciales
Volumenes
SecurityGroup
...
...


