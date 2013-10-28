### [Ejercicios 1 y 2](https://github.com/torresj/IV-GII-13-14/blob/master/ejerciciosT2-1y2.md)

### Ejercicio 3

	1. Usar debootstrap (o herramienta similar en otra distro) para crear un sistema mínimo que 
	   se pueda ejecutar más adelante.

		Simplemente con poner 'sudo debootstrap --arch=amd64 quantal /home/jaulas/quantal/	
		http://archive.ubuntu.com/ubuntu' instalaremos quantal en nuestra distro, en mi caso 
		ubuntu 13.04 amd64.

![captura1](https://dl.dropboxusercontent.com/u/17453375/capturaejercicio3.png)


	2. Experimentar con la creación de un sistema Fedora dentro de Debian usando Rinse.

		En primer lugar, hay que instalar rinse que se encuentra en los repositorios de ubuntu. 
		una vez hecho esto instalamos fedora poniendo "sudo rinse --arch=amd64 --distribution 
		fedora-core-6 --directory /home/jaulas/fedora/"

![captura2](https://dl.dropboxusercontent.com/u/17453375/fedora.png) 

![captura3](https://dl.dropboxusercontent.com/u/17453375/fedora2.png)

### Ejercicio 4
	
	Instalar alguna sistema debianita y configurarlo para su uso. Trabajando desde terminal, 
	probar a ejecutar alguna aplicación o instalar las herramientas necesarias para compilar una 
	y ejecutarla.

	Voy a usar el sistema instalado en el ejercicio 3 , ubuntu 13.10 amd64. Ahora podemos usarlo
	para lo que queramos. Como viene en los apuntes podemos montar /proc y probar la orden top.

![captura4](https://dl.dropboxusercontent.com/u/17453375/top.png)

	Como ejemplo yo he instalado git, para poder gestionar mis repositorios desde este sistema.
	En la siguiente imagen vemos como git esta instalado y podemos usarlo.

![captura5](https://dl.dropboxusercontent.com/u/17453375/git.png)


### [Ejercicios 5 y 6](https://github.com/torresj/IV-GII-13-14/blob/master/ejerciciosT2-5y6.md)