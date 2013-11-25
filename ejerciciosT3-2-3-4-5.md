### Ejercicio 2

	Comprobar qué interfaces puente ha creado y explicarlos

	Como puede verse en las imagenes siguientes, se ha creado un puente llamado
	lxcrb0 para poder tener acceso a la red desde el contenedor. Tambien se
	observa la diferenciea entre mirar los puentes con el contenedor lanzado,
	y con el contenedor sin lanzar. Cuando no esta lanzado, el puente no tiene
	asociado ninguna interface y el id parece ser generico, mientras que cuando
	se lanza el contenedor podemos observar que si se asigna una id y que se le
	asocia la interfaz vethP2A2KD.

![captura1](https://dl.dropboxusercontent.com/u/17453375/interfaces.png)


### Ejercicio 3

	1. Crear y ejecutar un contenedor basado en Debian.

	He optado por crear un contenedor con ubuntu cloud. Para ello usamos el
	comando 'sudo lxc-create -t ubuntu-cloud -n nubecilla'.

![captura2](https://dl.dropboxusercontent.com/u/17453375/nubecilla.png)

	Ahora solo nos bastaria usar 'sudo lxc-start -n nubecilla' y entrariamos
	en el sistema con usuario y contraseña "ubuntu".

![captura3](https://dl.dropboxusercontent.com/u/17453375/nubecilla2.png)

![captura4](https://dl.dropboxusercontent.com/u/17453375/nubecilla3.png)


	2. Crear y ejecutar un contenedor basado en otra distribución, tal como 
	   Fedora. Nota En general, crear un contenedor basado en tu distribución 
	   y otro basado en otra que no sea la tuya.

	voy a intentar crear un contenedor con fedora dentro de mi ubuntu 13.10.
	El procedimiento es igual que antes solo que ahora, si intentamos poner
	'sudo lxc-create -t fedora -n fedora14 -- -R 14' vemos que obtenemos un 
	error.

![captura5](https://dl.dropboxusercontent.com/u/17453375/errorfedora.png)

	Instalamos curl y yum tal como nos avisa lxc en caso de no tenerlos y
	lo intentamos de nuevo, siendo el proceso identico al anterior.

	Nota: Puede haber un posible error con esta orden ya que parece ser que hay
	problemas con el alojamiento en el que esta fedora.


### Ejercicio 4

	1. Instalar lxc-webpanel y usarlo para arrancar, parar y visualizar 
	   las máquinas virtuales que se tengan instaladas.

	Primero nos vamos a la pagina de lxc-webpanel y seguimos los pasos. Tras poner
	'wget http://lxc-webpanel.github.io/tools/install.sh -O - | sudo bash' vemos 
	como se instala.

![captura6](https://dl.dropboxusercontent.com/u/17453375/lxc-webpanel.png)

	Tras la instalación ya podemos usarlo simplemente poniendo 'localhost:5000'
	en nuestro navegador.

	Nota: La instalación puede tardar bastante.

![captura7](https://dl.dropboxusercontent.com/u/17453375/lxc-webpanel2.png)


	2. Desde el panel restringir los recursos que pueden usar: CPU shares, CPUs 
	   que se pueden usar (en sistemas multinúcleo) o cantidad de memoria.

	Para limitar los recursos de memoria o cpus solo tenemos que pinchar en el
	panel izquierdo sobre el contenedor que queramos. Se nos mostrara un menu
	como el de la imagen.

![captura8](https://dl.dropboxusercontent.com/u/17453375/lxc-webpanel3.png)


### Ejercicio 5

	Comparar las prestaciones de un servidor web en una jaula y el mismo servidor
	en un contenedor. Usar nginx.
	
	Vamos a usar la jaula ya creada en el tema anterior y el contenedor usado en este
	tema con un ubuntu. Usando ab compararé las prestaciones. Primero entramos con
	lxc-start -n ubuntu en el contenedor e instalamos nginx. Ahora con AB realizamos
	peticiones concurrentes al servidor. Primero necesitamos saber la ip para el
	contenedor. Podemos abrir el lxcWebPanel para establecer la ip. Ponemos el siguiente
	comando para realizar las peticiones:

		ab -n 10000 -c 1000  http://10.0.3.5/

	Ahora entramos en la jaula chroot y lanzamos nginx (en teoria es lo mismo que si 
	instalamos nginx en el sistema anfitrion y lo lanzamos ahi). Volvemos a realizar las
	peticiones con:

		ab -n 10000 -c 1000  http://localhost/

	En la siguiente imagen podemos ver como es mas rapido usar una jaula chroot que un
	contenedor, algo de esperar ya que el contenedor usa el puente a la interfaz de red
	lo cual provoca esos retrasos en las peticiones.

![captura9](https://dl.dropboxusercontent.com/u/17453375/comparativa.png)
