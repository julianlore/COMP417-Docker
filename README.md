# COMP417-Docker
Dockerfile and scripts to facilitate using ROS for assignments

Run `make build` to download the required files from the assignment
repo and build a docker container based off
`osrf/ros:melodic-desktop-full` with a persistent volume. Then run
`make` to enter the container. This no longer creates a new container
every time, so you don't have to clean until you're fully done. `make clean` will delete the created
container and the image.
