echo "You are about to destroy:"
echo "Apk-server image / Apk-server container"

read -p "Type YES to continue: " confirmation

if [ "$confirmation" == "YES" ]; then
    echo "Removing apk-server Container"
    docker container rm $(docker container ls | grep apk-server | awk '{print $1 }') --force
    echo "Removing apk-server image"
    docker image rm $(docker image ls | grep apk-server | awk '{ print $3}') --force 
else
    echo "Aborted."
fi
