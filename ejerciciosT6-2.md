## Ejercicio 6

### Instalar una máquina virtual Debian usando Vagrant y conectar con ella.

Lo primero que debemos hacer es instalar vagrant.

	sudo apt-get install vagrant

El siguiente paso es usar una de las imagenes de debian para vagrant que 
podemos encontrar en [http://www.vagrantbox.es/](http://www.vagrantbox.es/) y inicializarla.

	vagrant box add debian https://dl.dropboxusercontent.com/u/197673519/debian-7.2.0.box
	vagrant init debian

![captura1](https://dl.dropboxusercontent.com/u/17453375/vagrant1.png)

Después ya solo nos queda lanzarla y conectarnos.

	vagrant up
	vagrant ssh

![captura2](https://dl.dropboxusercontent.com/u/17453375/vagrant2.png)

![captura3](https://dl.dropboxusercontent.com/u/17453375/vagrant3.png)



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


Las líneas que hay después de provider sirven para activar la red ya que 
no se por que dentro de la maquina virtual no hay conexion a internet.
Después podemos ver que hemos usado "shell". Poniendo inline podemos
mandar ejecutar cualquier orden. Con la siguiente orden se ejecutan
los comandos para aprovisionar.

	vagrant provision

![captura4](https://dl.dropboxusercontent.com/u/17453375/vagrant4.png)


## Ejercicio 8

### Configurar tu máquina virtual usando vagrant con el provisionador ansible

Primero voy a crear una maquina virtual nueva, por ejempo otra debian mas ligera.

	vagrant box add debian https://www.dropbox.com/s/gxouugzbnjlny1k/debian-7.0-amd64-minimal.box



El siguiente paso es inicializarla y editar el archivo Vagrantfile para indicarle
que vamos a usar ansible. Además habrá que asignarle una dirección ip para usarla
en ansible.

	Vagrant.configure("2") do |config|
		config.vm.box = "debian"
		config.vm.network :private_network, ip: "192.168.33.10"

		config.vm.provision "ansible" do |ansible| 
			ansible.playbook = "playbook.yml"
		end

	end

En mi caso prmero he lanzado la maquina añadiendo solo la linea que
configura la ip para asegurarme de que no había errores. El resto lo añado 
al final para hacer "vagrant provision".

Una vez que tenemos configurado vagrant, solo nos queda configurar ansible
igual que hemos hecho en el ejercicio 5. Creamos un archivo para indicar
la dirección ip del equipo a configurar y después configuramos la variable
de sesión para indicar donde se encuentra.

	[debian]
	192.168.33.10




	export ANSIBLE_HOSTS=~/IV/vagrant/ansible_hosts




Ahora ya solo nos que crear el archivo playbook.yml

	---
	- hosts: debian
	  sudo: yes
	  tasks:
	    - name: Actualizar
	      apt: update_cache=yes
	    - name: Instalar Nginx
	      apt: name=nginx state=present


Como la maquina está ya arrancada, solo tenemos que aprovisionarla

	vagrant provision


nota: Puede que el servicio nginx no se haya iniciado automaticamente.
      Podemos añadir otra linea mas al playbook.yml con "sudo start nginx",
      o entrar con "vagrant ssh" y arrancarlo directamente.


![captura5](https://dl.dropboxusercontent.com/u/17453375/vagrant5.png)

![captura6](https://dl.dropboxusercontent.com/u/17453375/vagrant6.png)

