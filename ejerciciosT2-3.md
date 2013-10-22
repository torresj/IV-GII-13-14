### [Ejercicios 1 y 2](https://github.com/torresj/IV-GII-13-14/blob/master/ejerciciosT2-1y2.md)

### Ejercicio 3

	1. Usar debootstrap (o herramienta similar en otra distro) para crear un sistema mínimo que se pueda ejecutar más adelante.

		Simplemente con poner 'sudo debootstrap --arch=amd64 quantal /home/jaulas/quantal/	http://archive.ubuntu.com/ubuntu'
		instalaremos quantal en nuestra distro, en mi caso ubuntu 13.04 amd64.

![captura1](https://dl.dropboxusercontent.com/u/17453375/capturaejercicio3.png)


	2. Experimentar con la creación de un sistema Fedora dentro de Debian usando Rinse.

		En primer lugar, hay que instalar rinse que se encuentra en los repositorios de ubuntu. una vez hecho esto instalamos
		fedora poniendo "sudo rinse --arch=amd64 --distribution fedora-core-6 --directory /home/jaulas/fedora/"

![captura2](https://dl.dropboxusercontent.com/u/17453375/fedora.png) 

![captura3](https://dl.dropboxusercontent.com/u/17453375/fedora2.png)