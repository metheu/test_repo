#!/bin/bash

branch=$1
app_name=my_node
DOCKER_USERNAME=mattb912
DOCKER_PASSWORD=s3dd8zdCVK

# get version number
# this has to be entered manually and always up to date!

version="$(awk '$2 == "MY_APP" { print $3; exit}' Dockerfile)"
echo "version to be used is: $version"

# lets check of branch arguement 
if [  -z $branch ]; then
    echo "Branch is not defined!" && exit
fi

case $branch in 
    dev)
        echo "branch is dev.."
        ;;
    qa)
        echo "branch is qa.."
        ;;
    master)
        echo "branch is master.."
        ;;
    *)
        echo "undefined.."
        ;;
esac

# build docker image
docker build -t $app_name .

docker tag my_node $DOCKER_USERNAME/my_node-$branch:latest

docker tag my_node $DOCKER_USERNAME/my_node-$branch:$version

docker images

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push $DOCKER_USERNAME/my_node-$branch:$version && docker push $DOCKER_USERNAME/my_node-$branch:latest


