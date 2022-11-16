contenedor
    Puedo solicitar a docker una redirección de puertos
    
docker container create \
    -p ip-host:puerto-host:puerto-contenedor \
    imagen
        
        ip_host: 0.0.0.0    Mascara de red: TODAS LAS IPS
    
IPS de mi host
    - Red de amazon:         172.31.20.70
    - Red de loopback:       127.0.0.1 (localhost)
    - Red virtual de docker: 172.17.0.1
    
    
# REGEX

Lo que hacemos es definir una REGEX: EXPRESION REGULAR.
Qué es una expresión regular?
    Es una secuencia(conjunto) de patrones
    Qué es un patrón? 
        Es un conjunto de caracteres seguidos de un modificador de cantidad
    
    conjunto de caracteres. Ejemplos:     Interpretación                    Texto           Encuentro el patrón en el texto?
        hola                                literalmente                    hola amigos !       SI (1)
                                                                            ^^^^
                                                                            
        [hola]                              alguno de esos caracteres       hola amigos !       SI (6)
                                                                            ^ ^  ^
                                                                             ^ ^     ^
    
        [a-z]                               algun caracter entre la a y la z
        [A-Za-záñü]
        [0-9]                               Un caracter entre el 0 y el 9
        [1-37]                              Un caracter entre el 1  el 3 
                                            y el caracter 7
        [a-z-]                              Los caracteres de la a, a la z y el guión
        .                                   Cualquier caracter
        [.]                                 El punto
        \.
    
    modificador de cantidad 
        No poner nada                       1 vez
        ?                                   puede paracer o no          0 o 1 vez
        +                                   Al menos 1 vez              De 1 en adelante
        *                                   Puedo no paracer o aparecer las veces que quiera
                                                                        De 0 en adelante
        {4}                                 4 veces
        {3,7}                               De 3 a 7 veces
        {3,}                                Al menos 3 veces
    
    Especiales:
        ^       Comienza el texto
        $       Acaba el texto
        |       O
        ()      Agrupan
        

Quiero un patrón para los números del 0 al 19

    1?[0-9]

Nombre de persona de una palabra, no compuesto

    [A-Z][a-z]{2,}

Nombre de una persona, incluyendo nombres compuestos.

    Jose
    Maria Eugenia
    Maria Antonia de los Angeles
    Maria de los Angeles
    
    [A-Z][a-z]{2,}( (([a-z]{1,3} ){0,2}[A-Z][a-z]{2,}))*

regex101

En Terraform usamos INTENSIVAMENTE expresiones regulares,
ya que tenemos muchas variables de texto que validar.

Por suerte, seguramente no somos la primera persona en el mundo en necesitar
un determinado patrón.
Y google será vuestra salvación.
IP.   ^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]?|0)\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]?|0)$


# Quiero un output, con las ips de los contenedores
# Y otro con la ip del balanceador



[
  "contenedor1: 172.17.0.6",
  "contenedorB: 172.17.0.7",
]

{
    "contenedor1": "172.17.0.6",
    "contenedorB": "172.17.0.7"
}


