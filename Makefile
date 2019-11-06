XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

# all target based off of https://stackoverflow.com/questions/16296753/can-you-run-gui-applications-in-a-docker-container/25280523#25280523
.PHONY: all
all: src build
	touch $(XAUTH)
	xauth nlist $$DISPLAY | sed -e 's/^..../ffff/' | xauth -f $(XAUTH) nmerge -
	sudo docker run -ti -v $(XSOCK):$(XSOCK) -v $(XAUTH):$(XAUTH) -e XAUTHORITY=$(XAUTH) -e DISPLAY=$$DISPLAY mros

.PHONY: build
build:
	sudo docker build -t mros .

.PHONY: clean
clean:
	sudo docker rm $$(sudo docker ps -a -q)
src:
	mkdir -p src
	cd src && svn export https://github.com/dmeger/COMP417_Fall2019/trunk/particle_filter_question && \
		svn export https://github.com/dmeger/COMP417_Fall2019/trunk/estimation_assignment
