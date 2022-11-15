# Scripts de terraform 

Un script de terraform es un programa que está ubicado en una carpeta y que consta de un montón de ficheros con extensión .tf.
HCL: Lenguaje declarativo.

En esos fichero .tf definimos:
- providers M
- resources M
- output    M
- variables M/X
- provisioners J
- data    J
- modules J/V

#  Cliclo de vida

A Los scripts de terraform, les podemos aplicar distintos comandos:
- terraform init                    Descargar los proveedores
- terraform validate                Valida la sintaxis
- terraform plan                    Planificar las tareas que son necesarias llevar a cabo 
                                    para que el ESTADO del sistema que estamos definiendo
                                    coincida con lo que tenemos definido en el script.
- terraform apply                   Ejecuta esas tareas
- terraform destroy                 Liquida TODO 

# Providers en Terraform 

Un programa que contacta con un proveedor de Recursos. Algunos necesitan configuración.. otros no.

# Uso habitual de terraform 

Script de terraform -> repositorio de git
Irá evolucionando... Pasando por versiones... Tendremos versiones de la infra v1: 3 servidores  terraform apply (+3 servidores)
                                                                              v2: 5 servidores  terraform apply (+2 servidores)
                                                                              v3: 4 servidores. terraform apply (-1 servidor)
Cuando el proeycto muerta, desmantelo la infra:                                                 terraform destroy

## Primeros ejemplos:

Provider:   Docker 

#### Contenedores:

Crear un contenedor:

1º Imagen de contendor
2º Crear el contenedor:
    - Volumenes
    - Redirecciones de puertos
    - Variables de entorno
    
    
# Tipos de datos que asignar a las propiedade los recursos:

bool                        # Valor lógico
string                      # Texto
number                      # Numero
list(bool|string|number)    # Lista de cositas...   Puedo acceder a cada cosita por su posición
set(bool|string|number)     # Lista de cositas...   No puedo acceder a cada cosita por su posición
                            # Solo puedo iterarlo
map(bool|string|number)     # Mapa, Diccionario, Array asociativo. Conjunto claves-valor
object                      # Mapa donde hay unas claves predeterminadas
any                         # cualquier cosa
---
block set
block list                  No se pone el signo igual, y para cada bloque repito el elemento principal


YA TENGO MI SCRIPT DE TERRAFORM GUAY (es una kk... pero yo estoy feliz por ahora )

Qué toca ahora?

Quién lo corre? YO? con mis manitas? (manazas????)
                    Ni de coña !
                Servidor de automatización: Jenkins, AzureDevops....
                Y después? hay que hacer más? 
                    Ansible, Ejecutar unos tests....
                Puedo ejecutar ya un ansible? o un test?
                Al nginx? ... y qué se de él? Su IP? para atacarlo?

Una vez ejecutamos un script de terraform, terraform creará cosas... 
y me hará falta inforamción de esas cosas que se han creado, no?

Terraform, cada vez que aplicamos una infra, genera un fichero .tfstate
que tiene formato JSON, y que detaalla todos los datos de los recursos que se han creado


OUTPUTS


## JSON ?

Una notación para escribir datos... pero no una cualquiera... 
es la notación con la que se escriben datos en el lenguaje JavaScript

JavaScript Object Notation
var numero = 8
             true
             "Hola"
             [1,3,5,7]
             {
                 clave1: "Valor1",
                 "clave2": true
             }
             
# Variables

Permiten personalizar un script.

Nunca una variable puede quedarse desasignada. 

Terraform no lo permite.

Para las variables que en tiempo de ejecución estén desasignadas, 
terraform nos solicitará un valor.

También podemos en el comando pasar un valor para una variable
$[...] --var 'VARIABLE=VALOR'

**NOTA:** Al que haga esto, le cortamos las uñas muy cortitas, 
pero muy cortitas y le metemos las manos en un vaso con zumo de limón !!!!!

    No deja huella, como la lejía estrella ! RUINA !!!!! Muy mala práctica

**NOTA2:** Salvo gloriosas exceptiones !

    Salvo que NO QUIERA DEJAR HUELLA !  Credencial !
    
Los valores de las variables los definimos en un fichero con extensión .tfvars
Esos ficheros los puedo suministrar como argumento:
$[...] --var-file 'fichero'

Hay unos ficheros especiales, que son los ficheros con extensión:
.auto.tfvars
Los valores de variables que se definan en este fichero, se cargan por defecto,
aunque serían sobreescritos por los suministrados mediante los argumentos 
--var --var-file