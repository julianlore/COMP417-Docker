XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

.PHONY: all
all:
	sudo docker start cmros
	sudo docker exec -it cmros /ros_entrypoint.sh /bin/bash
	sudo docker stop cmros

# create based off of https://stackoverflow.com/questions/16296753/can-you-run-gui-applications-in-a-docker-container/25280523#25280523
.PHONY: build
build: A2/src
	sudo rm -rf $(XAUTH)
	sudo docker build -t mros .
	touch $(XAUTH)
	xauth nlist $$DISPLAY | sed -e 's/^..../ffff/' | xauth -f $(XAUTH) nmerge -
	sudo docker create -ti --name cmros -v $(XSOCK):$(XSOCK) -v $(XAUTH):$(XAUTH) -v $(shell pwd)/A2:/A2 -e XAUTHORITY=$(XAUTH) -e DISPLAY=$$DISPLAY mros

.PHONY: clean
clean:
	sudo docker rm cmros
	sudo docker rmi mros
A2/src:
	mkdir -p A2/src
	cd A2/src && svn export https://github.com/dmeger/COMP417_Fall2019/trunk/particle_filter_question && \
		svn export https://github.com/dmeger/COMP417_Fall2019/trunk/estimation_assignment
