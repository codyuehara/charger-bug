#!/bin/bash

IMAGE_NAME=ros2-humble

help()
{
    echo ""
    echo "Usage: $0 -w dev_ws -t localhost/ros2-humble-dev -b"
    echo -e "\t-w Workspace folder name"
    echo -e "\t-i Image to build/run"
    echo -e "\t-h show help"
    exit 1
}

while getopts "h:j" opt
do 
    case "$opt" in 
	j) jetson=1 ;;
	h | ?) help ;;
    esac
done

if [ -n "$jetson" ]; then
    echo "building Jetson"
    docker build -f Dockerfile.jetson --build-arg WORKSPACE=$workspace -t $IMAGE_NAME .
else
    docker build -f Dockerfile.dev --build-arg WORKSPACE=$workspace -t $IMAGE_NAME .
fi 
