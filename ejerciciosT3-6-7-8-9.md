### Ejercicio 6

	1. Instalar juju

	2. Usándolo, instalar MySql en un taper.

	Seguimos los pasos que vienen en los apuntes y ejecutamos los siguientes
	comandos en la terminal:

	sudo add-apt-repository ppa:juju/stable
	sudo apt-get update && sudo apt-get install juju-core
	juju init

	Editamos el archivo /home/jaime/.juju/environments.yaml y cambiamos
	'default: amazon' por 'default: local'. Con esto vamos a trabajar en
	local, aunque necesitaremos instalar MongoDb para que funciones.

	Para crear los tapers, lo primero que debemos hacer es ejecutar
	'juju bootstrap'. Despues solo tenemos que poner 'juju deploy mysql'
	y ya tenemos un taper con mysql instalado.

	Con juju status podemos ver el estado de los tapers y de los servicios.
	Además con lxcWebPanel podemos tambien ver las maquinas creadas con juju.



### Ejercicio 7

	1. Destruir toda la configuración creada anteriormente
	
	2. Volver a crear la máquina anterior y añadirle mediawiki y una 
	   relación entre ellos.
	
	3. Crear un script en shell para reproducir la configuración usada en 
	   las máquinas que hagan falta.

	Para destruir un taper primero hay que destruir las unidades que tenga.
	En este caso es mysql, que podemos quitar poniendo 'sudo juju destroy-unit 
	mysql/0'. Después ya podemos eliminar el taper con 'sudo juju 
	destroy-machine n' donde n es el número concreto de taper a eliminar.

	Para volver a crear la maquina, seguimos los pasos del ejercicio 6 y 
	además ponemos 'juju deploy mediawiki' para añadir esta unidad. Después
	creamos una relación entre ambas unidades con 'juju add-relation 
	mediawiki:slave mysql:db'. Por último solo nos establecer como publica
	la unidad mediawiki para que se pueda acceder a través de la ip del taper,
	que podemos ver con 'juju status'. Para ello ponemos 'juju expose mediawiki'

	Para poder hacer este proceso mas cómodo podemos crear un script que cree
	el taper, dando por hecho que juju esta instalado y que ya se ha usado
	'juju bootstrap'. el script sería el siguiente:

		#!/bin/bash
		juju add-machine
	    juju deploy mediawiki
	    juju deploy mysql 
	    juju add-relation mediawiki:slave mysql:db 
	    juju expose mediawiki 
	    juju status

	Para lanzarlo solo hay que darle permiso de ejecución y hacerlo siempre con
	permisos de superusuario. 



### Ejercicio 8

	Instalar libvirt

	Primero descargamos he instalamos con 'sudo apt-get install kvm libvirt-bin'

![captura1](https://dl.dropboxusercontent.com/u/17453375/libvirt.png)

	Después añadimos el usuario con 'sudo adduser $USER libvirtd'

![captura2](https://dl.dropboxusercontent.com/u/17453375/libvirtUser.png)

	Por ultimo instalamos virtinstall 'sudo apt-get install virtinst'

![captura3](https://dl.dropboxusercontent.com/u/17453375/virt.png)

	Ya podemos usar libvirt para la gestión de maquinas virtuales.



### Ejercicio 9

	Instalar un contenedor usando virt-install.

	Como ya tenemos instalado virt-install, lo priemro que hacemos es
	usar una imagen de un sistema, en mi caso uso un ubuntu 13.10 
	que ya tenía descargado. Colocamos el archivo iso en /var/lib/libvirt/images.
	Por ultimo creamos la maquina virtual usando los parametros de virt-install.
	'sudo virt-install 
		-n ubuntu -r 512 
		--file=/var/lib/libvirt/images/ubuntu-13.10-desktop-amd64.img 
		--file-size=4 
		--cdrom=/var/lib/libvirt/images/ubuntu-13.10-desktop-amd64.iso'

	Las opciones son , por orden, el nombre de la maquina, la ram asignada,
	el archivo para la imagen, el tamaño del archivo de imagen y el archivo
	iso o la ruta de la unidad de disco donde esta.

	Para que la instalación funcione tenemos que isntalar antes virt-viewer.
	Como se ve en la imagen el proceso de instalación sigue los pasos normales
	del disco de isntalación del sistema operativo que hayamos elegido.

![captura4](https://dl.dropboxusercontent.com/u/17453375/virt-install.png)