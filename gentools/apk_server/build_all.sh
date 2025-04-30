clear
echo "Build Docker Image"
docker run --rm --workdir /work -v ${PWD}:/work cgr.dev/chainguard/apko build apk_server.yaml apk-server:latest apk_server.tar --arch amd64

echo "Cleaning old docker image"
docker image rm $(docker image ls | grep apk_server | awk '{ print $3 }') --force

echo "Load Docker file"
docker load < apk_server.tar

echo "Run from folder where packages folders are located"

