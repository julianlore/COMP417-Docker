FROM osrf/ros:melodic-desktop-full

RUN mkdir -p /src/
WORKDIR /src/
COPY . /src/
