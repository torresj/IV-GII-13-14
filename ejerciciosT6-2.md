## Ejercicio 6

### Instalar una máquina virtual Debian usando Vagrant y conectar con ella.

Lo primero que debemos hacer es instalar vagrant.

	sudo apt-get install vagrant

El siguiente paso es usar una de las imagenes de debian para vagrant que 
podemos encontrar en [http://www.vagrantbox.es/](http://www.vagrantbox.es/) y inicializarla.

	vagrant box add debian https://dl.dropboxusercontent.com/u/197673519/debian-7.2.0.box
	vagrant init debian

![captura4](https://dl.dropboxusercontent.com/u/17453375/vagrant1.png)

Después ya solo nos queda lanzarla y conectarnos.

	vagrant up
	vagrant ssh

![captura4](https://dl.dropboxusercontent.com/u/17453375/vagrant2.png)

![captura4](https://dl.dropboxusercontent.com/u/17453375/vagrant3.png)



## Ejercicio 7

### Crear un script para provisionar `nginx` o cualquier otro servidor web que pueda ser útil para alguna otra práctica

Usando vagrant, solo tenemos que editar el archivo "Vagrantfile".

	# -*- mode: ruby -*-
	# vi: set ft=ruby :

	Vagrant.configure("2") do |config|
	  config.vm.box = "prueba"
	  config.vm.provider "virtualbox" do |v|
	    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	  end
	  config.vm.provision "shell",
	    inline: "sudo apt-get install -y nginx && sudo service nginx restart && sudo service nginx status"

	end


Las lineas que despues de provider sirven para activar la red ya que no 
se por que dentro de la maquina virtual no hay conexion a internet.
Después podemos ver que hemos usado "shell". Poniendo inline podemos
mandar ejecutar cualquier orden.


![captura4](https://dl.dropboxusercontent.com/u/17453375/vagrant4.png)