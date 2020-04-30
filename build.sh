#!/bin/bash

DIST="build"
NAME="stellar-account-viewer"

# find and remove previous containers
docker ps -a -q --filter "name=$NAME" | grep -q . && docker stop $NAME && docker rm -fv $NAME
docker build -t $NAME .
# expose ports for copying files to local file system
docker run -p 8080:8080 --name $NAME $NAME:latest $1
# remove previous build from local file system
# and copy new one from docker
rm -rf ../$DIST
docker cp $NAME:/$NAME/.tmp/webpacked $DIST
# cleanup
docker stop $NAME
docker rm $NAME
