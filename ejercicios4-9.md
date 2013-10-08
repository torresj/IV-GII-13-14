### Ejercicio 5 y 6

    Ya que ambos ejercicios persiguen el uso de git y la familiarización con su uso,
    simplemente con usar git para subir el archivo con los objetivos cumplidos queda
    demostrado la realización de estos ejercicios.

### Ejercicio 7

    1. Crear diferentes grupos de control sobre un sistema operativo Linux. Ejecutar 
    en uno de ellos el navegador, en otro un procesador de textos y en uno último 
    cualquier otro proceso. Comparar el uso de recursos de unos y otros durante un 
    tiempo determinado.

    Podemos crear y gestionar grupos de dos maneras: creando la carpeta dentro de
    cgroups o usando la biblioteca libcgroup. Voy a usar esta última.

    * En primer lugar creo un grupo con la siguiente orden:

      sudo cgcreate -a jaime -g memory,cpu,cpuacct:ejercicio7

    * Después creo tres subgrupos para controlar el navegador, el editor de textos y
      el programa gimp para tratamiento de imagenes:
      
      sudo cgcreate -g memory,cpu,cpuacct:ejercicio7/navegador
      sudo cgcreate -g memory,cpu,cpuacct:ejercicio7/editor
      sudo cgcreate -g memory,cpu,cpuacct:ejercicio7/imagenes
      
    * Una vez que tenemos los subgrupos, ejecutamos cada aplicación en su grupo:
      
      sudo cgexec -g memory,cpu,cpuacct:ejercicio7/navegador firefox
      sudo cgexec -g memory,cpu,cpuacct:ejercicio7/editor gedit
      sudo cgexec -g memory,cpu,cpuacct:ejercicio7/imagenes gimp
     
    * Por último, solo tenemos que buscar los archivos que hay, en mi caso, en la 
      siguiente carpeta(Dentro tenemos una carpeta por cada subgrupo: navegador, 
      editor e imagenes):
      
      cd /sys/fs/cgroup/cpuacct/ejercicio7
      
      
    * Para cada subgrupo, buscamos dentro de la carpeta anterior los archivos:
         - cpuacct.stat: tiempo consumido de sistema y de usuario.
         - cpuacct.usage: tiempo consumido de CPU.
         - cpuacct.usage_percpu: tiempo consumido por cada CPU (En caso de haber mas de una).
    * Para ver otro recurso, como la memoria por ejemplo, la carpeta seria:
      
      cd /sys/fs/cgroup/memory/ejercicio7
      
    * Dentro de ella podemos ver, por ejemplo, el archivo memory.max_usage_in_bytes para
      conocer la máxima cantidad de memoria utilizada.

    * Tabla comparativa

 | Firefox | Gedit | Gimp
----- |----- | ----- | -----
cpuacct.stat | user:342 system: 82 | user: 90 system: 4 | user: 405 system: 51
cpuacct.usage |4453737450 | 984116819 | 4761160601
cpuacct.usage_percpu |CPU0: 2426991530 CPU1: 2030689661 | CPU0: 646322951 CPU1: 337793868 | CPU0: 2725775758 CPU1: 2035384843
memory.max_usage_in_bytes | 262348800 | 11563008 | 77271040

*Convendría que pusieras los resultados numéricos para ver la diferencia en gasto de CPU de cada uno de los grupos*


### Ejercicio 8

  2. Implementar usando el fichero de configuración de cgcreate una política que dé menos 
     prioridad a los procesos de usuario que a los procesos del sistema (o viceversa).

     Para realizar este ejercicio necesitamos editar el archivo /etc/cgconfig.conf. Ahora
     podemos hacer que los cambios no se borren al reiniciar añadiendo a este archivo las
     ordenes para montar los cgroups y crear los que nos interese o bien simplemente crear
     nosotros los grupos y usar este archivo para indicar que limitaciones va a tener cada
     grupo. Para nuestro caso podemos poner, suponiendo que hay un grupo para usuario y otro
     para sistema:

       group usuario {

          cpu {

             cpu.shares=20

       }

      Con esto indicamos que este grupo tiene el 20% de los recursos de la CPU.

      Por ultimo, para poder hablar de usuarios en vez de procesos podemos usar cgred. Para ellos
      editamos el archivo /etc/cgrules.conf. En el podemos poner, por ejemplo:

        jaime     devices   /usuario

      Asi cualquier proceso lanzado por jaime se movería al grupo usuario