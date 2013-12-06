### Ejercicio 1

	1. ¿Cómo tienes instalado tu disco duro? ¿Usas particiones? ¿Volúmenes lógicos?

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


	2. Si tienes acceso en tu escuela o facultad a un ordenador común para las prácticas,
	   ¿qué almacenamiento físico utiliza?

	3. Buscar ofertas SAN comerciales y comparar su precio con ofertas locales 
	   (en el propio ordenador) equivalentes.




### Ejercicio 2

	Usar FUSE para acceder a recursos remotos como si fueran ficheros locales. 
	Por ejemplo, sshfs para acceder a ficheros de una máquina virtual invitada 
	o de la invitada al anfitrión.

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
