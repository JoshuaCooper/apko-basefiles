#!/bin/bash

# Check if Go is installed
if command -v go >/dev/null 2>&1; then
    echo "Go is installed"
else
    echo "Go not found, please install to continue"
    exit 1
fi

# Check if Docker is installed
if command -v docker >/dev/null 2>&1; then
    echo "Docker is installed"
else
    echo "Docker not found, please install to continue"
    exit 1
fi

if command -v apko >/dev/null 2>&1; then
    echo "APKO is installed"
else
    echo "APKO not found, please install to continue"
    exit 1
fi

if [ -d "output" ]; then
    echo "Directory 'output' already exists"
else
    mkdir output
    echo "Directory 'output' created"
fi

if [ -d "packages" ]; then
    echo "Directory 'packages' already exists"
else
    mkdir output
    echo "Directory 'packages' created"
fi

# Check if container with that name is running
if docker ps --filter "name=^/${container_name}$" --filter "status=running"
then
    echo "APK-Server is already running on 8000"
    echo "-- Stop container and delete image if you want it rebuilt"
    echo "-- exiting"
    exit
else
    echo "Failed to start APK-Server container"
    docker build -t apk-server .
    container_name="apk-server"
    image_id=$(docker image ls | grep $container_name | awk '{ print $3}')
    docker run -v ./packages:/work/packages -d --name "$container_name-runtime" -p 8000:8000 $image_id
    # Check if the image has been built and is added.
    # TODO - Check if image isn't built / imported. != - build 
fi
