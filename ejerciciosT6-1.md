## Ejercicio 1

### Instalar chef en la máquina virtual que vayamos a usar

Voy a usar una maquina virtual ubuntu server 13.10 ya creada en
azure. Entramos con ssh y instalamos ruby y chef.


	sudo apt-get install ruby1.9.1 ruby1.9.1-dev rubygems
	curl -L https://www.opscode.com/chef/install.sh | bash

![captura1](https://dl.dropboxusercontent.com/u/17453375/chefinstall.png)


## Ejercicio 2

### Crear una receta para instalar nginx, tu editor favorito y algún directorio y fichero que uses de forma habitual.

Vamos a crear una receta para instalar nginx, emacs, un directorio y 
un archivo. Creamos un directorio cookboks y dentro ponemos las recetas.

* NGINX 

Creamos una carpeta con el nombre de la receta, y dentro de esta, 
creamos un fichero de metadatos y una carpeeta recipes con el 
archivo default.rb dentro.

el siguiente archivo con metadatos es valido para las tres recetas
por lo que solo muestro el de nginx (solo habria que cambiar el nombre
de la receta y la descripcion).

	maintainer       "Jaime Torres"
	maintainer_email "jtbenavente@gmail.com"
	description      "instala nginx"

	recipe "emacs", "Receta para instalar nginx"


Para que se instale solo tenemos que poner lo siguiente en
el archivo default.rb

	package 'nginx'



* EMACS

	es exactamente igual que el anterior solo cambiando
	nginx por emacs.



* DATOS

Ahora vamos a crear una carpeta y dentro de ella un archivo, readme.txt.
Para ello la receta sería:

	directory '/home/jaime/datos'
	file "/home/jaime/datos/readme.md" do
	 	owner "jaime"
	  	group "jaime"
	  	mode 00764
	  	action :create
	  	content "datos varios"
	end



Ya tenemos las tres recetas, por ultimo debemos crear dos archivos
para que chef funcione: solo.rb y node.json.


* solo.rb

Indicamos el path de las recetas y del archivo json

	cookbook_path File.expand_path("../cookbooks", __FILE__)
	json_attribs File.expand_path("../node.json", __FILE__)


* node.json

En este archivo se indican los atributos de las recetas y la forma
de ejecutarse.

	{
	    "nginx": {
	        "version"   : "1.4.1",
	        "user"      : "www-data",
	        "port"      : "80"
	  },

	    "emacs": {
	        "version"   : "23.4.1"
	    },

	    "datos": {
	        "name"      : "datos"
	    },

	    "run_list": [
	        "recipe[nginx]",
	        "recipe[emacs]",
	        "recipe[datos]"
	    ]
	}


Ya tenemos todo lo que necesitamos, ahora podemos pasarlo a la maquina virtual
de azure mediante sftp o creando un proyecto en github y clonandolo.
Una vez tenemos la carpeta con las recetas en la maquina virtual ya podemos
lanzar chef.

	sudo chef-solo -c chef/solo.rb -j chef/node.json

![captura2](https://dl.dropboxusercontent.com/u/17453375/chef.png)

Podemos ver que todo ha sido correcto haciendo un ls para mostrar
la carpeta creada con el archivo dentro y mirando que nginx y emacs
estan instalados.

![captura3](https://dl.dropboxusercontent.com/u/17453375/recetas.png)

##Ejercicio 3

### Escribir en YAML la siguiente estructura de datos en JSON: { 'uno': 'dos', 'tres': [ 4, 5, 'Seis', { 'siete': 8, 'nueve': [10,11] } ] }

Para una estructura tan básica lo que debemos saber de YAML es:

* Clave:valor

		color: rojo

Nota: Aunque el valor sea una cadena de texto no es necesario ponerla
entre comillas, aunque si es recomendable por legibildiad

* Padre-hijo

Es igual que en python, tabulando.

	rectangulo:
		alto:4
		ancho:2


* Listas

Tenemos dos formas, poniendolas entre corchetes y separados por comas
o igual que una relación padre-hijo pero poniendoles delante un guión.
Usando la segunda forma podemos tener tambien listas dentro de listas.

	coche:[seat,mercedes]
	coche:
		-seat
		-mercedes

	coche:
		-seat:[leon,altea]
		-mercedes:["clase A","Clase B"]



Con esto ya podemos representar la estructura en YAML

	uno:"dos"
	tres:
		-4
		-5
		-"Seis"
		-
			-siete:8
			-nueve:[10,11]



## Ejercicio 4

### Desplegar los fuentes de la aplicación de DAI o cualquier otra aplicación que se encuentre en un servidor git público en la máquina virtual Azure (o una máquina virtual local) usando ansible.

Lo primero que hacemos es instalar python-dev, python-pip y git si no lo 
teníamos ya instalado. Ahora ya podemos instalar ansible.

	sudo pip install paramiko PyYAML jinja2 httplib2 ansible


El siguiente paso es indicar a ansible la dirección de las maquinas que
va a controlar. Para ello creamos un archivo, en mi caso ansible_hosts,
y le indicamos a ansible su path. Dentro de este archivo ponemos:

	[azure]
	pruevas-iv.cloudapp.net

y establecemos la variable de entorno.

	export ANSIBLE_HOSTS=~/ansible_hosts
	echo $ANSIBLE_HOSTS
	ansible azure -m ping

![captura4](https://dl.dropboxusercontent.com/u/17453375/ansible.png)

Ahora usamos ansible para clonar mi repositorio con la práctica
de DAI.

	ansible azure -m git -a "repo=https://github.com/torresj/cafe.git dest=~/ version=HEAD"

![captura4](https://dl.dropboxusercontent.com/u/17453375/ansible2.png)


Por ultimo podemos entrar en la maquina virtual y ver que se ha clonado 
el repositorio.

![captura4](https://dl.dropboxusercontent.com/u/17453375/tree_ansible.png)


## Ejercicio 5

### 1. Desplegar la aplicación de DAI con todos los módulos necesarios usando un playbook de Ansible.

Una vez realizado el ejercicio anterior solo tenemos que crear las reglas
para instalar todos los paquetes necesarios para poder lanzar la aplicación.
Para ellos usamos los playbooks de ansible, que son ficheros en formato YAML.

dai.yml

	---
	- hosts: azure
	  sudo: yes
	  tasks:
	    - name: Instalar Python python-pip y build-essential
	      apt: name=build-essential state=present
	      apt: name=python-dev state=present
	      apt: name=python-pip state=present
	    - name: Instalar MongoDB
	      apt: name=mongodb-server state=present
	    - name: Instalar módulos de Python necesarios
	      command: pip install web.py mako pymongo feedparser tweepy
	    - name: Desplegar aplicación
	      command: chdir=/home/jaime/cafe nohup python main.py 80 &
	      async: 50
	      poll: 0


![captura4](https://dl.dropboxusercontent.com/u/17453375/ansible_dai.png)

En la imagen podemos ver que pone "finished" en el ultimo proceso. Esto no se debe 
a ningun error de ansible, el problema está en que he instalado mongoDB pero no he 
inicializado la base de datos, y cuando la aplicación ha echo la primera consulta 
se ha producido un error. Copiamos la base de datos y la aplicación funciona perfectamente.


![captura4](https://dl.dropboxusercontent.com/u/17453375/ansible_cafe.png)

No puedo dejar esta maquina virtual encendida ya que para la aplicación
que desarrollamos en cocoroco use mi cuenta para crear la maquina donde
se aloja y no puedo tener ambas encendidas. No obstante en la captura se
puede ver que la dirección web es la de la maquina virtual del ejercicio.


### 2. ¿Ansible o Chef? ¿O cualquier otro que no hemos usado aquí?.

Contestado en el issue
