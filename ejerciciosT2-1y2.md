### Ejercicio 1

Crear un espacio de nombres y montar en él una imagen ISO de un CD de forma que no se pueda leer más que desde él. Pista: en ServerFault nos explican como hacerlo, usando el dispositivo loopback

	Para realizar este ejercicios tenemos que usar el comando unshare con la opcion -m para montajes con mount.
	Una vez hecho, usamos 'mount -o loop discoquesea.iso /mnt/disk' donde /mnt/disk es una carpeta que tiene que estar 
	creada previamente. El resultado es que hemos montado un disco pero que solo modemos leer desde dentro, al poner exit
	el disco se desmonta. En la siguiente imagen se muestran las ordenes en la terminal.

![captura](https://dl.dropboxusercontent.com/u/17453375/loopMount.png)

### Ejercicio 2

	1. Mostrar los puentes configurados en el sistema operativo.
		Mi pc no tiene ningun puente.

![captura2](https://dl.dropboxusercontent.com/u/17453375/puentesvirtuales.png)

	2. Crear un interfaz virtual y asignarlo al interfaz de la tarjeta wifi, si se tiene, o del fijo, si no se tiene.
		Al intentar añadirlo a wlan0 me da un error pero en cambio si lo añado a cualquier otra interfaz no da
		problemas

![captura](https://dl.dropboxusercontent.com/u/17453375/puenteWlan0.png)


### [Ejercicio 3](https://github.com/torresj/IV-GII-13-14/blob/master/ejerciciosT2-3y4.md)
