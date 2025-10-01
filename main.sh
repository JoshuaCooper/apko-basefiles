#!/bin/bash
version=0.1
packer_image='packinfo'

source functions.sh

clear
echo "" 
cat logo.txt
echo "Version: "$version

mkdir -p dotnet_apko
mkdir -p python_apko
mkdir -p bash_apko
mkdir -p tmp

#docker load < ./tmp/$packer_image.tar

packer_id=$(docker image ls | grep $packer_image | awk '{ print }')
if [[ -n "$packer_id" ]]; then
    docker image rm $packer_id --force
else
    echo "Packer Image isn't  currently loaded"
fi
apko_build "pack_info"

if [[ -f ./tmp/$pack_info.tar ]]; then
    docker load < ./tmp/$packer_image.tar
else
    echo "./tmp/$pack_info.tar does not exist."
fi

#docker image ls | grep $packer_image | awk '{ print }'

# Obtain package information - should be a function 
#dotnet8version=$(docker run -it packinfo:latest-dev-amd64 /bin/bash -c "apk update && apk add dotnet-8 dotnet-8-runtime aspnet-8-runtime && dotnet --list-runtimes" | grep netcore -i | awk '{ print $2}')
# Clean Docker Container

