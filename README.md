# COMP417-Docker
Dockerfile and scripts to facilitate using ROS for assignments

Run `make` to download the required files from the assignment repo and
build a docker container based off ros containing those files. If you
run `make` often (i.e. you are editing the source locally and then
rebuilding), you should occasionally run `make clean` to delete all
containers (note if you have other docker containers, this will also
delete them! check with `docker ps -a -q` to see what will be deleted)
