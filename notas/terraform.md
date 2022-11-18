# Terraform
- [Terraform](#terraform)
  - [Qué es Terraform](#qué-es-terraform)
    - [Arquitectura](#arquitectura)
  - [Flujo de trabajo de Terraform.](#flujo-de-trabajo-de-terraform)
    - [init.](#init)
    - [validate](#validate)
    - [plan](#plan)
    - [apply](#apply)
    - [refresh](#refresh)
    - [destroy](#destroy)
  - [Módulos.](#módulos)
  - [Componentes de configuración de terraform](#componentes-de-configuración-de-terraform)
    - [provider](#provider)
    - [provisioner](#provisioner)
    - [resource](#resource)
    - [datasource](#datasource)
    - [variable](#variable)
    - [output](#output)
  - [Referencias, funciones y más](#referencias-funciones-y-más)
    - [referencias](#referencias)
    - [Tipos de datos.](#tipos-de-datos)
    - [Funciones integradas.](#funciones-integradas)
    - [dynamic blocks](#dynamic-blocks)
    - [Comentarios de Terraform.](#comentarios-de-terraform)
## Qué es Terraform

Es una herramienta declarativa de aprovisionamiento que se basa en el paradigma de la infraestructura como código.

Está diseñado sobre principios de infraestructura inmutable.

Características:
- Es de código abierto
- Escrito en Golang
- Utiliza su propia sintaxis: HCL (lenguaje de configuración Hashicorp). También es compatible con JSON
- Ayuda a evolucionar la infraestructura de forma segura y predecible
- Aplica la teoría de gráficos a IaaC y proporciona automatización, control de versiones y reutilización
- Permite adquirir crecursos de múltiples niveles (SaaS / PaaS / IaaS)
- Un modelo de arquitectura basado en complementos
- Compatible con todos los principales proveedores cloud

### Arquitectura

![Arquitectura](https://www.datocms-assets.com/2885/1509044297-terraform-google-calendar-plugin-architecture.svg)

## Flujo de trabajo de Terraform.

![Flujo de trabajo](https://st6.io/static/80d3ec377107b7ccb39cd350e0f8a7e6/1d69c/terraform-execution-flow.png)

### init.

Inicializa un directorio de trabajo que contiene archivos de configuración de Terraform.

Realiza la inicialización de backend (almacenamiento para archivo de estado terraform).

Instala los módulos del registro terraform a la ruta local.

Instala los complementos del proveedor(es), los complementos se descargan en el subdirectorio del directorio de trabajo actual dentro del directorio .terraform/plugins.

Es seguro ejecutarlo varias veces, para actualizar el directorio de trabajo con los cambios en la configuración.

No elimina la configuración o el estado existente.

### validate

Valida sintácticamente el formato de los archivos de terraform.

Verifica si una configuración es sintácticamente válida e internamente coherente, independientemente de las variables proporcionadas o del estado existente.

Se realiza una verificación de sintaxis en todos los archivos de terraform en el directorio, mostrando un error si alguno de los archivos no se valida.


### plan

Crear un plan de ejecución.

Calcula la diferencia entre el último estado conocido y el estado actual, y presenta las diferencias encontradas

No modifica la infraestructura ni el estado.

Permite al usuario ver qué acciones realizará Terraform antes de realizar cualquier cambio para alcanzar el estado deseado.

Escaneará todos los *.tf  archivos en el directorio y creará el plan.

### apply

Aplicar los cambios necesarios para alcanzar el estado deseado.

Escanea el directorio actual en busca de la configuración y aplica los cambios de manera apropiada.

Modificará la infraestructura y el estado.

Si un recurso se crea correctamente pero falla durante el aprovisionamiento, Terraform producirá un error y marcará el recurso como "tainted".

Terraform no revierte y destruye automáticamente un recurso si hay un error en el provisionamiento, porque eso iría en contra del plan de ejecución: el plan de ejecución dice que se cree un recurso, pero no dice que se elimine.

### refresh

Utilizado para syncronizar el estado que conoce Terraform (a través de su archivo de estado) con la infraestructura real.

No modifica la infraestructura, pero modifica el archivo de estado.

### destroy

Destruye la infraestructura y todos los recursos.

Modifica tanto el estado como la infraestructura.

## Módulos.

Permiten la reutilización de código.

Admiten el control de versiones para mantener la compatibilidad.

Almacenan el código de forma remota.

Permiten la encapsulación con todos los recursos separados en un bloque de configuración.

Los módulos se pueden anidar dentro de otros módulos, lo que le permite activar rápidamente entornos completamente separados.

Puede ser referido usando el atributo source.

Admite módulos locales y remotos.

Los módulos locales se almacenan junto con la configuración de Terraform (en un directorio separado, fuera de cada entorno pero en el mismo repositorio).

Los módulos remotos se almacenan externamente en un repositorio separado y admiten control de versiones.Terraform admite los siguientes backends:
- Registro de Terraform.
- GitHub.
- Bitbucket.
- Git genérico, repositorios de Mercurial.
- URL HTTP.
- Buckets S3.
- Buckets de GCS.

Más información: https://www.terraform.io/docs/language/syntax/configuration.html

## Componentes de configuración de terraform 

### provider

Son responsables de comprender las interacciones de la API y exponer los recursos.

Proporcionan una capa de abstracción por encima de la API.

Terraform admite múltiples instancias de proveedores.

Se puede integrar con cualquier API utilizando el marco de proveedores.

Más información: https://www.terraform.io/docs/language/syntax/configuration.html

### provisioner

Permiten ejecutar código de forma local o remota durante la creación o borrado de recursos.

El ejecutor local (local_exec) ejecuta código en la máquina que ejecuta terraform.

El ejecutor remoto (remote_exec) se ejecuta en el recurso aprovisionado. Se conecta mediante ssh o winrm, y requiere una lista de comandos para ejecutar en una terminal.

Si falla la ejecución del ejecutor, se dara el aprovisionamiento como fallido. Este comportamiento se puede anular configurando on_failure al valor to continue.

Más información: https://www.terraform.io/docs/language/syntax/configuration.html

### resource

Son el elemento más importante en el lenguaje Terraform, y describen uno o más objetos de infraestructura, como instancias, etc.

Juntos, el tipo de recurso y el nombre sirven como un identificador para un recurso y deben ser únicos dentro de un mñodulo.

Más información: https://www.terraform.io/docs/language/syntax/configuration.html#

### datasource

Permiten extaer datos para su uso en cualquier otro lugar de la configuración de Terraform.

Permiten que una configuración de Terraform haga uso de información definida fuera de Terraform.

Más información: https://www.terraform.io/docs/language/data-sources/index.html

### variable

Sirven como parámetros para un módulo de Terraform y actúan como argumentos de función.

Permiten personalizar aspectos del módulo sin alterar el código fuente propio del módulo, y permite que los módulos se compartan entre diferentes configuraciones.

Se puede definir de varias formas.
- Mediante línea de comando: -var="nombre=valor".
- Mediante archivos de definición de variables .tfs o .tfvars. 
- Las variables de entorno se pueden usar para establecer variables usando el formato TF_VAR_name.

Más información: https://www.terraform.io/docs/language/values/variables.html

### output

Son como valores de retorno de funciones.

La salida se puede marcar como que contiene material sensible utilizando el argumento opcional sensitive, que evita que Terraform muestre su valor en la salida. Sin embargo, esto no evita que se almacenen en el estado como texto plano.

En un módulo principal, las salidas de los módulos secundarios están disponibles en expresiones como  module.<MODULE NAME>.<OUTPUT NAME>.

Más infomación: https://www.terraform.io/docs/language/values/outputs.html

## Referencias, funciones y más 

### referencias

Son expresiones que hace referencia al valor asociado para un recurso.

Más información: https://www.terraform.io/docs/language/expressions/references.html

### Tipos de datos.
Admite los siguientes tipos de datos:
- string
- number
- bool
- list - una secuencia de valores identificados por números enteros consecutivos que comienzan con cero.
- map - una colección de valores donde cada uno está identificado por una etiqueta de texto.
- set - una colección de valores únicos que no tienen identificadores secundarios ni orden.

Más información: https://www.terraform.io/docs/language/expressions/types.html

### Funciones integradas.

Terraform incluye una serie de funciones integradas que pueden ser llamadas desde dentro de las expresiones para transformar y combinar los valores para, por ejemplo min, max, file, concat, element, index, lookupetc.

Terraform no admite funciones definidas por el usuario.

Más información: https://www.terraform.io/docs/language/syntax/configuration.html

### dynamic blocks

Actúan como una expresión for, pero producen bloques anidados.

Itera sobre un valor complejo dado y genera un bloque anidado para cada elemento de ese valor complejo.

Más información: https://www.terraform.io/docs/language/expressions/dynamic-blocks.html

### Comentarios de Terraform.

Admite tres sintaxis diferentes para comentarios:

- \# comentario
- // comentario
- /* comentario */