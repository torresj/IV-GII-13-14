## Ejercicio 1

### Instalar los paquetes necesarios para usar KVM. Se pueden seguir estas instrucciones. Ya lo hicimos en el primer tema, pero volver a comprobar si nuestro sistema está preparado para ejecutarlo o hay que conformarse con la paravirtualización.

En primer lugar hay que asegurarse de que nuestro procesador soporta la virtualizacion.
Despues comprobamos que esta activada la virtualizacion.

	egrep -c '(vmx|svm)' /proc/cpuinfo
	kvm-ok

![captura1](https://dl.dropboxusercontent.com/u/17453375/kvm-ok.png)

Por ultimo instalamos los paquetes necesarios para utilizar kvm.

	sudo apt-get install qemu-kvm qemu-system libvirt-bin virtinst virt-manager



## Ejercicio 2

### 1. Crear varias máquinas virtuales con algún sistema operativo libre, Linux o BSD. Si se quieren distribuciones que ocupen poco espacio con el objetivo principalmente de hacer pruebas se puede usar CoreOS (que sirve como soporte para Docker) GALPon Minino, hecha en Galicia para el mundo, Damn Small Linux, SliTaz (que cabe en 35 megas) y ttylinux (basado en línea de órdenes solo).


Lo primero es activar el modulo de virtualizacion.

	sudo modprobe kvm-intel

Vamos a empezar instalando coreOS con Quemu. Necesitamos descargarnos la imagen del sistema de
http://storage.core-os.net/coreos asi como su script de ejecucion.

![captura2](https://dl.dropboxusercontent.com/u/17453375/coreos.png)

Ahora vamos a instalar otro SO ligero, ttylinux. Una vez descargada la imagen de este sistema, creamos
un disco duro virtual y despues lanzamos el sistema con quemu.

	qemu-img create -f raw hdd.img 200M
	qemu-system-x86_64 -hda hdd.img -cdrom ttylinux-virtio_x86_64-16.1.iso -show-cursor

![captura3](https://dl.dropboxusercontent.com/u/17453375/ttylinux.png)


### 2. hacer un ejercicio equivalente usando otro hipervisor como Xen, VirtualBox o Parallels.

Voy a usar VirtualBox para cargar un ubuntu server 12.04, que es un sistema mas exigente que 
los anteriores y tarda bastante mas en instalarse. En la siguientes capturas se puede ver
alguno momentos de la creación de la maquina virtual, y el sistema ya funcionando.

![captura4](https://dl.dropboxusercontent.com/u/17453375/vb.png)

![captura5](https://dl.dropboxusercontent.com/u/17453375/vb2.png)

![captura6](https://dl.dropboxusercontent.com/u/17453375/vb3.png)

![captura7](https://dl.dropboxusercontent.com/u/17453375/vb4.png)

![captura8](https://dl.dropboxusercontent.com/u/17453375/vb5.png)


## Ejercicio 4

### Crear una máquina virtual Linux con 512 megas de RAM y entorno gráfico LXDE a la que se pueda acceder mediante VNC y ssh.

Podemos instalar Lubuntu, cuyo entorno grafico es LXDE. Podemos descargarlo de su pagina oficial.

	qemu-img create -f qcow2 hdd.img 15G
	qemu-system-x86_64 -hda hdd.img -cdrom lubuntu-12.04-desktop-amd64.iso -m 512M


![captura9](https://dl.dropboxusercontent.com/u/17453375/lubuntu.png)

No se por que no llega a instalarse, probando con sistemas de 64 y 32 bits, 
asi que en vez de usar quemu voy a intentarlo con VirtualBox. El problema es 
que con virtualbox no podemos usar VCN.


![captura10](https://dl.dropboxusercontent.com/u/17453375/lubuntu2.png)

![captura11](https://dl.dropboxusercontent.com/u/17453375/lubuntu3.png)

![captura12](https://dl.dropboxusercontent.com/u/17453375/lubuntu4.png)

![captura13](https://dl.dropboxusercontent.com/u/17453375/lubuntu5.png)

Para conectar mediante ssh instalamos openssh-server en la maquina virtual y
en la configuracion de virtualbox añadimos una regla para la rer redirigiendo
las conexiones desde el puerto 2222 al 22 para conectarnos por ssh. Despues solo
nos queda acceder desde el equipo anfitrion.

	ssh -p 2222 lubuntu@localhost


![captura14](https://dl.dropboxusercontent.com/u/17453375/lubuntu6.png)

![captura15](https://dl.dropboxusercontent.com/u/17453375/lubuntu7.png)

![captura16](https://dl.dropboxusercontent.com/u/17453375/lubuntu8.png)


## Ejercicio 5

### Crear una máquina virtual ubuntu e instalar en ella un servidor nginx para poder acceder mediante web.

Voy a suar la cuenta de azure pa crear la maquina virtual. Podemos elegir una imagen 
de las que dispone azure, una vez elegida la creamos con:

	azure vm create jtbenaventeUbuntu b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-13_10-amd64-server-20131215-en-us-30GB jaime clave --location "West Europe" --ssh

Despues la lanzamos.

	azure vm start jtbenaventeUbuntu 

![captura17](https://dl.dropboxusercontent.com/u/17453375/azureUbuntu.png)

En la imagen podemos ver que en la aplicacion web ya aparece la maquina que acabamos
de crear. Debemos de añadir un extremo para el protocolo http para que permita el acceso.
En la propia pagina de azure podemos hacerlo de forma rapida y sencilla

![captura18](https://dl.dropboxusercontent.com/u/17453375/azureUbuntu2.png)

Ahora que ya tenemos la MV podemos instalar el servidor web. para ello accedemos
mediante ssh.

	ssh jaime@jtbenaventeubuntu.cloudapp.net

![captura18](https://dl.dropboxusercontent.com/u/17453375/azureUbuntu3.png)

Una vez dentro actualizamos el sistema y después instalamos nginx.

	sudo apt-get install nginx

Por ultimo podemos editar el archivo index.html de nginx para personalizarlo y cargar 
la pagina con la direccion de la maquina virtual, http://jtbenaventeubuntu.cloudapp.net/. 
Antes tenemos que lanzar el servicio.

	sudo service nginx start



![captura19](https://dl.dropboxusercontent.com/u/17453375/azureUbuntu4.png)


## Ejercicio 7

### Instalar una máquina virtual Ubuntu 12.04 para el hipervisor que tengas instalado.

Lo primero es instalar los paquetes necesarios.

	ubuntu-vm-builder kvm virt-manager

Despues creamos la imagen.

	sudo vmbuilder kvm ubuntu --suite precise --flavour server -o --dest ~/pruebas/iv 
	--hostname jaimeiv --domain jaimeiv

Tras unos minutos, ya tendremos un archivo con la imagen de disco y un script llamado
run.sh que si lo ejecutamos, lanzara la maquina virtual.

![captura19](https://dl.dropboxusercontent.com/u/17453375/vmbiulder.png)

	
