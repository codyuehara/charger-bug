#!/bin/bash

IMAGE_NAME=charger
ARCH=$(uname -m)

help()
{
    echo ""
    echo "Usage: $0 -w dev_ws -t localhost/ros2-humble-dev -b"
    echo -e "\t-w Workspace folder name"
    echo -e "\t-i Image to build/run"
    echo -e "\t-h show help"
    exit 1
}

while getopts "h" opt
do 
    case "$opt" in 
	h | ?) help ;;
    esac
done

if [ $ARCH="x86_64" ]; then
    echo "building on Host"
    docker build -f Dockerfile.dev --build-arg WORKSPACE=$workspace -t $IMAGE_NAME .
elif [ $ARCH="aarch64" ]; then
    echo "building Jetson"
    docker build -f Dockerfile.jetson --build-arg WORKSPACE=$workspace -t $IMAGE_NAME .
fi 
