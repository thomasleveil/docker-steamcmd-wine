docker-steamcmd-wine
====================

Dockerfile building an image with steamcmd and wine ready to go


Building
--------

    git clone https://github.com/thomasleveil/docker-steamcmd-wine.git
	cd docker-steamcmd-wine
	make build
	
or
	
	docker build --tag steamcmd-wine github.com/thomasleveil/docker-steamcmd-wine
	
	
Running
-------

	docker run --tty --interactive tomdesinto/steamcmd-wine /home/steam/steamcmd/steamcmd.sh +login <your steam account>
	
	
	
Other
-----

    make shell
	
Will run the container and present you with a shell.