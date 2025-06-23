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

# If both are installed
apko build apk_server.yaml apk-server:latest ./output/apk-server.tar --sbom=false


# Check for apk-server.tar and load it with Docker if it exists
if [ -f "output/apk-server.tar" ]; then
    echo "Found output/apk-server.tar, loading into Docker..."
    docker load < output/apk-server.tar
else
    echo "apk-server.tar not found in output/"
fi



container_name="apk-server"
docker run -d --name "$container_name" -p 8000:8000 $(docker image ls | grep $container_name | awk '{ print $3}')


sleep 3

# Check if container with that name is running
if docker ps --filter "name=^/${container_name}$" --filter "status=running" | grep -qw "$container_name"; then
    echo "APK-Server started on 8000"
else
    echo "Failed to start APK-Server container"
fi

