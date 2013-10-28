### [Ejercicios 3 y 4](https://github.com/torresj/IV-GII-13-14/blob/master/ejerciciosT2-3y4.md)

### Ejercicio 5

	Instalar una jaula chroot para ejecutar el servidor web de altas prestaciones nginx

	En primer lugar instalamos un sistema minimo con 'sudo debootstrap --arch=amd64 quantal
	/home/jaulas/nginx/ http://archive.ubuntu.com/ubuntu'. Ahora añadimos un usuario a
	la jaula con 'sudo useradd -s /bin/bash -m -d /home/jaulas/nginx/./home/jtorres -c 
	"Raring jaime" -g users jtorres'. Ya solo nos queda instalar nginx en nuestro sistema.
	En mi caso he descargado nginx para compilarlo. Para ellos he instalado el compilador
	de c además de algunas bibliotecas que pide nginx para configurarse correctamente.
	Ponemos ./configure dentro de la carpeta que nso hemos descargado con nginx y se configura
	y lanza.

![captura1](https://dl.dropboxusercontent.com/u/17453375/nginx.png)

	Por ultimo solo nos queda ingresar con el usuario que habiamos creado poniendo su - jtorres.
	Para comprobar que el servidor web funciona podemos usar curl, el cual nos permite ver
	contenido html en la consola.


### Ejercicio 6

	Crear una jaula y enjaular un usuario usando `jailkit`, que previamente se habrá tenido 
	que instalar.

	Siguiendo las instrucciones de los apuntes, descargamos de internet el paquete de jailkit
	y lo instalamos poniendo './configure && make && sudo make install'. Una vez instalado hay
	que seguir los siguientes pasos:

		1. Creamos el sistema de ficheros con permisos para root.
			
			mkdir -p /seguro/jaulas/dorada
			chown -R root:root /seguro

		2. Creamos la jaula con la funcionalidad que queramos.

			jkinit -v -j /seguro/jaulas/dorada jk_lsh basicshell netutils editors

		3. Creamos un usuario y lo enjaulamos.

			adduser usuario
			sudo jk_jailuser -m -j /seguro/jaulas/dorada usuario

		4.  Editamos la configuracion para permitir a este usuario tener acceso a la shell
			limitada.

			gedit /seguro/jaulas/dorada/etc/passwd

			Nos debe quedar algo como esto.

![captura](https://dl.dropboxusercontent.com/u/17453375/jilkit.png)

		5. por ultimo usamos control+alt+F2 e introducimos los datos de ese usuario. 
		   Podemos ver que apenas podemos hacer nada ya que es un terminal limitado.

