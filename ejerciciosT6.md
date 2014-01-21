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