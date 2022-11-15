# Terraform 

Es una herramienta que fabrica HashiCorp (Vagrant), que nos ofrece :
- Un lenguaje declarativo HCL (HashiCorp Language) - (infraestructura cómo código)
- Un intérprete con el que realizar comandos sobre ese fichero.

En definitiva sirve para gestionar(adquirir/liberar/mantener) recursos contra unos proveedores.
                                                                V                  V
El principal uso de terraform es la gestión automatizada de infraestructuras en clouds.

Vamos a estar escribiendo programas.

# Devops

Una filosofía, una cultura, un moviento en pro de AUTOMATIZACION.
Automatización de qué? De todo lo que hay entre el desarrollo y la operación de un sistema.

                                    AUTOMATIZABLE       QUIEN AUTOMATIZA?
    Plan                                        x
    Desarrollo                                  x                           -> GIT, SVN, Mercury
    Empaquetado                                 √
        JAVA:   maven, gradle, sbt                  |
        .NET:   msbuild, dotnet, nuget              |   desarrollo
        PYTHON: poetry                              |   
        JS:     yarn, npm, webpack                  |
    Pruebas                                     
        Definición                              x
        Ejecución                               √
            Selenium                                |
            Appium                                  |
            Katalon                                 |   testing Q&A
            Karate                                  |
            SoapUI                                  |
            Postman                                 |
            JMeter                                  |
            Loadrunner                              |
            * donde hago esas pruebas?
                En la máquina del desarrollador? Ni de coña
                En la del tester? Tampoco
                    * Son entornos que están maleados No tengo confianza en ellos
                En un entorno de testing, Pre, Q&A, (CONTENEDOR), integración
                    * Me fio de este entorno? 
                        La primera vez, quizás.. y la 20ava... Me fio?
                    * La tendencia a día de hoy es que este entorno sea de usar y tirar
                    * Vaya trabajón no? Automatizar la creación / disposición (eliminación) de ese entorno
            Terraform   |                                       |
            Vagrant     | Disponer de entornos                  |
            Kubernetes  |                                       |   
                                                                | sys admin / devops
            Ansible     |                                       |
            Puppet      | Aprovionamiento de esos entornos      |
            chef        |   Configurarlos, instalarles cosas... |
            Salt        |                                       |
        <-----------------------------------------------------------------------    Integración Continua
    Liberación de una release   
        <-----------------------------------------------------------------------    Entrega Continua
    Despliegue                                                                              CD
        <-----------------------------------------------------------------------    Despliegue Continua
    Operación
    Monitorización
    
Me falta una cosa por automatizar? La llamada a todos esos programas!
Orquestación de esos programas: Servidores de automatización CI/CD:
- Azure devops  Pipeline        |
- Jenkins                       |
- TravisCI                      |       Devops
- Bamboo                        |
- TeamCity                      |
- Gitlab CI/CD                  |
- Github actions                |
    

Infinitamente estoy en cada fase. 
El producto de una fase, pasa a la siguiente

Entorno de producción:
- Alta disponibilidad:
    Tratar de cumplir con un objetivo de tiempo de servicio: 99%        |   €
                                                             99,9%      |   €€
                                                             99,99%     |   €€€€€
                                                             99,999%    v   €€€€€€€€€€€€€€
    Tratar de impedir la PERDIDA DE INFORMACION: x3

    REPLICACION / REDUNDANCIA

- Escalabilidad
    Capacidad de ajustar la infra a las necesidades de cada momento

    App 3: INTERNET
        Dia n:          100 usuarios
        Dia n+1:    1000000 usuarios    BLACK FRIDAY
        Dia n+2:       2000 usuarios
        Dia n+3:   20000000 usuarios    CYBERMONDAY         Partido Madrid/Barça (web telepi)
            
            ESCALABILIDAD VERTICAL:         Más máquina     | Cluster Activo/Activo
            ESCALABILIDAD HORIZONTAL:       Más máquinaS    |
            
            
        Necesito en 15 minutos 20 maquinas nuevas
        Y en 2 horas eliminarlas.
    
# Clouds: El conjunto de servicios (TIC) que un proveedor ofrece:
1- a través de internet
2- mediante procesos automatizados y desatendidos
3- con cobro por uso

Los servicios pueden ser de varios tipos:
- Infraestructura (almacenamiento / cómputo): IaaS
- Plataforma      (base de datos):            PaaS
- Software        (cloud9):                   SaaS

Terraform nos permite automatizar nuestra parte del proceso de adquisición y liberación de servicios
en un proveedor (normalmente un cloud)

## Lenguaje HCL

Es un lenguaje declarativo para la ejecución de programas (creación de scripts), con una sintaxis mezcla de JSON y YAML:
- Creación/Mantenimiento de unos recursos en un proveedor
- Eliminación de esos recursos

Lenguaje de programación: Java, C#, ADA, Fortan, Python.
Tienen una gramática con su sintaxis y su semántica.

Los lenguajes, alguno, los podemos usar de diferentes formas, a la hora de expresar conceptos.
en el mundo de la programación, a esas formas de expresarnos las llamamos paradigmas de programación.
- Imperativa
- Procedural
- Funcional
- Orientada a Objetos
- Declarativa

Castellano:
- Tipos de sentencias (frases): Afirmativas, interrogativas, imperativas, declarativo

Si la silla no está debajo de la ventana            (IF)
    Pero hay algo debajo de la ventana
        Quita ese algo de debajo de la ventana
    Si no hay silla, compra una silla y luego 
    Pon la silla debajo de la ventana !             Tipo de oración: IMPERATIVA : ORDEN
    
    No le digo lo que quiero.. si no lo que debe hacer


Quiero una silla debajo de la ventana !      Tipo de oración: DESIDERATIVA / DECLARATIVO
    
    Aquí no le digo lo que debe hacer, le digo lo que quiero

El concepto de lenguaje declarativo, da lugar al concepto de IDEMPOTENCIA.  
    Da igual el estado del que yo parta en un momento dado. 
        Al ejecutar el script siempre debe quedar el mismo estado.
    
Habitualmente , cuando montamos scripts, usamos lenguaje imperativo: bash(sh), ps1, py
Estructuras/vocablos típicos de lenguaje imperativo: IF, ELSE, FOR, WHILE
ODIAMOS LOS LENGUAJES IMPERATIVOS... Son snecillos... a priori... pero muy tediosos... y proclives a errores.

NOS ENCANTA LOS LENGUAJES DECLARATIVOS.

Herramientas que usan lenguaje declarativo:
- Terraform 
- Ansible
- Kubernetes
    - Openshift

Al final en un fichero HCL: 
    Declarar recursos que quiero en un proveedor.
    Declaro infraestructura a crear en un cloud, en un fichero de código: Infraestructura como código.
    
## HCL

Alfabeto.
Sintaxis: Como se construyen frases (statements, en ese lenguaje)
Semantica: Lo que significan ciertas palabras

En los fichero HCL, vamos a hacer uso intensivo de:
- El signo igual
- Las llaves
- 8 palabras: (+ otras 20 que usaremos menos)
    - terraform
    - provider
    - variable
    - output
    - resource
    - data
    - provisioner
    - module

Imaginaros que quiero un servidor con 16 Gbs de RAM y 4 CPUs... 2 Tb de HDD...
pinchado en una red conectada a Internet
-> AWS
-> AZURE

Que bonito sería. NI DE COÑA ... NI PARECIDO ! Lo tengo que reescribir entero, hasta la ultima coma!

Ventajas de Terraform:
- Necesito aprender 1 única sintaxis, no una para cada proveedor
- Uso un lenguaje declarativo

AWS, tiene su propia herramienta cliente para automatizar trabajos en AWS... crear una instancia:
aws cli

---
Un fichero HCL siempre lleva una marca: terraform

terraform {
    # Establezco la configuración de terraform: 
        # La versión requerida de terraform y los proveedores que son necesarios.
    required_providers {
        aws = {
            source = Lugar donde encuentro el programa del proveedor
        }
    }
}

Cada proveedor, llevará su configruación específica:

provider "NOMBRE_DEL_PROVEEDOR" {
    propConfiguracion1 = valor
    propConfiguracion2 = valor
}
    
                                            CREDENCIALES
                                                V
script terraform -> terraform -> provider -> aws cli --> AWS
                                Es un programa desarrollador para terraform
                                que permite comunicar con un proveedor 

resource "TIPO" "NOMBRE" { # El nombre es un nombre que yo usaré dentro del script para referirme al recurso
    propiedades = valor
}

Un script de terraform es un conjunto de archivos con extensión: .tf
    Y nombre? El que me de la real gana !

Esos archivos estarán en una carpeta, separada paa ese script: CADA SCRIPT TIENE SU PROPIA CARPETA en terraform
De esa carpeta, terraform toma TODOS los archivos con extensión .tf y los une en uno solo que es el que ejecuta.

Terraform es insensible al ORDEN ! Cómo mola... Ya lo veremos ! ;)

A un script de terraform le puedo pedir varias cosas:
- Que se inicialice:                                                            $ terraform init
    La descarga de los proveedores que van a utilizarse
- Que se valide:                                                                $ terraform validate
- Que me explique terraform, las tareas que son necesarias                      $ terraform plan
  llevar a cabo para conseguir los recursos/infraque ahí están declarados
- Que aplique un plan                                                           $ terraform apply
    Que cree, borre o actualicxe los recursos existentes para 
    que cuadren con lo que establezco en el fichero
- Que elimine todos los recursos                                                $ terraform destroy


Proveedor: DOCKER 
                Recursos: imagenes, contenedores (volumenes, redes)

# Contenedorización:

1ª Qué es un contenedor?

Es un entorno aislado dentro de un SO con Kernel Linux donde ejecutar procesos.
Entorno aislado: Un contenedor tiene:
- su propia configuración de red: y por ende su propia IP(s)
- sus propias variables de entorno
- su propio sistema de archivo (filesystem)
- Y puede tener limitaciones de acceso al hardware del host

Los contenedores los creamos desde una Imagen de contenedor.

2º Qué es una imagen de contenedor?

Es un triste fichero comprimido (.tar) que contiene un programa YA INSTALADO y PRECONFIGURADO por alguien.
Además, en ese fichero comprimido, se incluyen librerias, dependencias y comandos adicionales que puedan 
requerirse o ser de ayuda.

3º Un contenedor ejecuta su propio SO?
   Una imagen de contenedor lleva un SO? NO
   
   Los contenedores no ejecutan un Sistema operativo propio. NUNCA, JAMAS, ES IMPOSIBLE !!!!!
   
   Solo hay un kernel de SO: el del host
   
   Esa es la gran diferencia respecto al coñazo de las mñaquinas virtuales.
   Por eso ya pasamos como el culo de las MV.... y nos molan mucho más los contenedores.
  
Servidor de 4 Tbs de RAM y 196 CPUs -> Varias MVs 

Bitmani!

...
PAUSA:

Quiero montar SQL Server en mi computadora Windows, que necesito hacer?
Paso 1: Comprobar los requisitos
Paso 2: Descargamos un INSTALADOR de SQL Server
Paso 3: Ejecutamos el instalador + configuración que yo aplique -> Instalación SQL Server
    c:\Archivos de Programa\SQLServer -> zip  y os la mando por email...
    Ese zip.. es una imagen de contenedor.


        App1 + App2 + App3              Problemas:  - Conflictos, requerimientos diferentes
    ------------------------                        - Seguridad
              SO                                    - Si app1 se vuelve loca (100% CPU). APP1 -> OFFLINE
    ------------------------                                                             APP2 y APP3 también
            HIERRO
            
            
        App1  |     App2 y App3
    ----------------------------------- Problemas:  - Deperdicio de recursos
        SO1   |         SO 2                        - Configuración compleja y más costosa de mantener
    -----------------------------------             - Rendimiento de las apps
        MV1   |         MV 2
    -----------------------------------
        Hipervisor: HyperV, KVM, VMWare
        Citrix, VirtualBOX
    -----------------------------------
            SO
    -----------------------------------
            HIERRO
            
            
        App1  |     App2 y App3
    -----------------------------------           
        C1    |         C 2
    -----------------------------------
        Gestor de contenedor:
        Docker, Podman, [Crio, Containerd]
    -----------------------------------
            SO Linux
    -----------------------------------
            HIERRO
            
Kubernetes, Openshift: Orquestadores de gestores de contenedores
Me sirven para controlar un cluster de gestores de contenedores para su uso en un entorno de producción

Cluste de Kubernetes:
    Maquina 1
        crio | containerd
    Maquina 2
        crio | containerd
    Maquina N        
        crio | containerd



Servidor web más usado en el mundo: nginx
    Puerto por defecto: 80
    
    curl http://localhost:80
    
    
docker container create  \
    --name minginx \
    -p 8080:80 \
    -e VARIABLE1=valor1 \
    -e VARIABLE2=valor2 \
    -v /home/ubuntu/environment/curso:/datos  \
    nginx:latest
    
    A nivel de docker un volume es una carpeta del host que comparto en el contenedor, en un punto de montaje 
    
docker exec minginx ls /
