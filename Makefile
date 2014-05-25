.PHONY: build shell run

DOCKER_IMAGE := tomdesinto/steamcmd-wine

build:
	docker build --rm --tag "$(DOCKER_IMAGE)" .
	
shell:
	docker run --rm --tty --interactive "$(DOCKER_IMAGE)" /bin/bash -l
	
run:
	@echo 'docker run --tty --interactive $(DOCKER_IMAGE) /home/steam/steamcmd/steamcmd.sh +login <your steam account>'
