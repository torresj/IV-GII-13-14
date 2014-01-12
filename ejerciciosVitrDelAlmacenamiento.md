## Ejercicio 1

###1. ¿Cómo tienes instalado tu disco duro? ¿Usas particiones? ¿Volúmenes lógicos?

Tengo el disco duro dividido en 4 particiones primarias, es decir, usando el máximo
de particiones que permite formato de tabla de particiones usual. No uso ninguna
extendida o lógica. En la siguiente imagen podemos ver la representación del disco
que nos da gparted. 

![captura1](https://dl.dropboxusercontent.com/u/17453375/discoduro.png)

Podemos ver las cuatro particiones que corresponden al recovery de windows y a windows,
y swap y ubuntu.

Tambien podemos saber que no tenemos particiones logicas instalando lvm2 y ejecutando
lvdisplay.

![captura2](https://dl.dropboxusercontent.com/u/17453375/lv.png)


###2. Si tienes acceso en tu escuela o facultad a un ordenador común para las prácticas,
¿qué almacenamiento físico utiliza?

###3. Buscar ofertas SAN comerciales y comparar su precio con ofertas locales 
(en el propio ordenador) equivalentes.




## Ejercicio 2

###Usar FUSE para acceder a recursos remotos como si fueran ficheros locales. 
###Por ejemplo, sshfs para acceder a ficheros de una máquina virtual invitada 
###o de la invitada al anfitrión.

Vamos a trabajar con la maquina afintriona y con el taper creado en temas 
anteriores "ubuntu" al que tendremos que establecer una direcion ip (con lxc-webpanel).
Despues instalamos en ambas maquinas sshfs. Como ejemplo, voy a crear una carpeta
en el taper llamada música, y voy a intentar montar todo el home en el equipo anfitrion
creando otra carpeta en él llamada musica_remota (Podrias montar directamente la carpeta 
musica pero no tiene nada dentro, copiando el home vemos que efectivamente funciona).

Lo primero es añadir el usuario al grupo FUSE con 'sudo gpasswd -a $USER fuse' (en el taper).
Despues ejecutamos 'sshfs ubuntu@10.0.3.5:/home ~/musica_remota' en el equipo anfitrion.
Si todo ha ido bien, podemos ver que dentro de la carpeta "musica_remota" tenemos el home
del taper, en este caso la carpeta del usuario "ubuntu" y dentro la carpeta que habiamos
creado "musica".

![captura3](https://dl.dropboxusercontent.com/u/17453375/sshfs1.png)

![captura4](https://dl.dropboxusercontent.com/u/17453375/sshfs2.png)

![captura5](https://dl.dropboxusercontent.com/u/17453375/sshfs3.png)



## Ejercicio 3

###Crear imágenes con estos formatos (y otros que se encuentren tales como VMDK) y 
###manipularlas a base de montarlas o con cualquier otra utilidad que se encuentre.

Podemos usar quemu para crear imagenes de varios formatos como son qcow2, raw o vmdk.

![captura6](https://dl.dropboxusercontent.com/u/17453375/formatos.png)	

Al no tener ningun formato de sistema de archivos no pueden ser montadas, daría un error.
Podemos, por ejemplo, convertir los archivos de imagen en ficheros loop y luego darles
formato para poder montarlos.

	losetup -v -f imagen

Ademas el formati vmdk es el que usa VMware, por lo que podríamos usarlo para montarlo
en una maquina virtual. El disco nuevo saldría pero no tendría formato.

### Ejercicio 4

Crear uno o varios sistema de ficheros en bucle usando un formato que no sea habitual 
(xfs o btrfs) y comparar las prestaciones de entrada/salida entre sí y entre ellos y 
el sistema de ficheros en el que se encuentra, para comprobar el overhead que se añade 
mediante este sistema.

Tal y como hemos hecho en el ejercicio anterior, debemos de crear una imagen con el formato
que sea, después convertirla en dispositivo loop, darle formato y montarla.

Las creamos:

	qemu-img create -f raw imagen-xfs.img 100M
	qemu-img create -f raw imagen-btrfs.img 100M


Las convertimos en dispositivos loop:

	sudo losetup -v -f imagen-xfs.img
	sudo losetup -v -f imagen-btrfs.img

Les damos el formato correspondiente:

	sudo mkfs.xfs /dev/loop0
	sudo mkfs.btrfs /dev/loop1

Y por ultimo las montamos (Los puntos de montaje deben exisitir):

	sudo mount /dev/loop0 /mnt/xfs/
	sudo mount /dev/loop1 /mnt/btrfs/

En las siguientes imagenes podemos ver como le hemos dado formato y además nos aseguramos
de que se han montado correctamente.

![captura7](https://dl.dropboxusercontent.com/u/17453375/loopFormatos.png)

![captura8](https://dl.dropboxusercontent.com/u/17453375/loopMontados.png)


## Ejercicio 5

###Instalar ceph en tu sistema operativo.

Con la siguiente orden instalamos ceph y todas sus dependencias

	sudo apt-get install ceph-mds



## Ejercicio 6

###Crear un dispositivo ceph usando BTRFS o XFS

Lo primero que vamos a hacer es crear las carpetas para ceph.

	sudo mkdir -p /srv/ceph/{osd,mon,mds}

Después creamos el archivo de configuración.

	sudo gedit /etc/ceph/ceph.conf

El contenido del archivo sería:

	[global]
    	auth cluster required = none
   		auth service required = none
    	auth client required = none
    	auth supported = none
    	log file = /var/log/ceph/$name.log
    	pid file = /var/run/ceph/$name.pid
	[mon]
    	mon data = /srv/ceph/mon/$name
	[mon.jtb]
    	host = jaime-VGN-FZ21E
    	mon addr = 127.0.0.1:6789
	[mds]
	[mds.jtb]
    	host = jaime-VGN-FZ21E
	[osd]
    	osd data = /srv/ceph/osd/$name
    	osd journal = /srv/ceph/osd/$name/journal
    	osd journal size = X
	[osd.0]
    	host = jaime-VGN-FZ21E
    	xfs devs = /dev/loop0

X es el tamaño que queramos darle.

Como podemos ver en la ultima linea, vamos a usar un dispositivo loop
con formato xfs que deberemos crear. Los comandos ya han sido comentados
en ejercicios anteriores.

![captura9](https://dl.dropboxusercontent.com/u/17453375/ceph1.png)

Ahora creamos una carpeta para el servidor de objetos.

	sudo mkdir /srv/ceph/osd/osd.0

Siguiendo el tutorial de ceph, el siguiente paso es crear el sistema de
ficheros de objetos.

	sudo /sbin/mkcephfs -a -c /etc/ceph/ceph.conf

![captura10](https://dl.dropboxusercontent.com/u/17453375/ceph2.png)

Por ultimo iniciamos el servicio y comprobamos el estado de ceph.

	sudo /etc/init.d/ceph -a start
	sudo ceph -s 


![captura11](https://dl.dropboxusercontent.com/u/17453375/ceph3.png)

![captura12](https://dl.dropboxusercontent.com/u/17453375/ceph4.png)

## Ejercicio 8

###Tras crear la cuenta de Azure, instalar las herramientas de línea de 
###órdenes (Command line interface, cli) del mismo y configurarlas con 
###la cuenta Azure correspondiente.

Para poder instalar el cliente de azure debemos instalar antes node.js

	sudo add-apt-repository ppa:chris-lea/node.js
	sudo apt-get update
	sudo apt-get install nodejs

Ahora ya podemos instalar azure-cli.

	npm install azure-cli

Tras la instalación ejecutamos el siguiente comando para descargar
la información de la cuenta.

	azure account download

Se nos abrira el navegador y se descargará un archivo que debemos importar.

	azure account import Azpad246MYE1091-1-12-2014-credentials.publishsettings

![captura13](https://dl.dropboxusercontent.com/u/17453375/azure1.png)

Por ultimo nos aseguramos de que todo ha sido correcto y que la cuenta está bien
configurada.

	azure account list

![captura13](https://dl.dropboxusercontent.com/u/17453375/azure2.png)

Despues podemos crear una cuenta de almacenamiento a traves de la pagina de azure
o usando el cliente de azure como se ve en lso apuntes de la asignatura.

	azure account storage create jtbenavente
	azure account storage keys list jtbenavente
	export AZURE_STORAGE_ACCOUNT=jtbenavente
	export AZURE_STORAGE_ACCESS_KEY="La clave que nos dan"
	echo $AZURE_STORAGE_ACCOUNT
	echo $AZURE_STORAGE_ACCESS_KEY


## Ejercicio 9

###Crear varios contenedores en la cuenta usando la línea de órdenes para ficheros 
###de diferente tipo y almacenar en ellos las imágenes en las que capturéis las 
###pantallas donde se muestre lo que habéis hecho.

Vamos a crear dos contenedores para almacenar, por un lado documentos y por otro imagenes.

	azure storage container create documents -p blob
	azure storage container create images -p blob

![captura14](http://jtbenavente.blob.core.windows.net/images/azure3.png)

Ahora ya podemos subir cualquier archivo a documents o images y será accesible
desde el navegador.

	azure storage blob upload ~/Imágenes/azure3.png images azure3.png

![captura15](http://jtbenavente.blob.core.windows.net/images/azure4.png)

Con este comando cambiando el archivo y el contenedor podemos subir lo que
queramos.

Las imagenes de este ejercicios estan cargadas desde azure para demostrar
que funciona el acceso publico.

* [http://jtbenavente.blob.core.windows.net/images/azure3.png](http://jtbenavente.blob.core.windows.net/images/azure3.png imagen)

* [http://jtbenavente.blob.core.windows.net/images/azure4.png](http://jtbenavente.blob.core.windows.net/images/azure4.png imagen)

* [http://jtbenavente.blob.core.windows.net/documents/document.txt](http://jtbenavente.blob.core.windows.net/documents/document.txt documento)

