#!/usr/bin/env bash

ARCHIVE_DIR="/var/cache/apt/archives"
TAR_PATH="archive.tar"

if [ $# -ne 2 ]
  then
    echo "Invalid number of arguments. Usage: download.sh <ubuntu_version> <package_name>"
    exit 1
fi

UBT_VER=$1; shift;
PACKAGE=$1; shift;

echo "start to build docker image"
docker build -t tmp_deb_img --build-arg ubuntu_version=${UBT_VER} .

if [ $? -eq 0 ]
  then
    echo "start to download deb packages and then put them into a tar file"
    docker run --rm -v tmp_deb:${ARCHIVE_DIR} -v $(pwd):/__tmp__ tmp_deb_img \
      /bin/bash -c "apt-get install -y --download-only ${PACKAGE}; tar cvf /__tmp__/${TAR_PATH} ${ARCHIVE_DIR}"
  else
    echo "Error found during building docker image. Process aborted and wait for cleaning."
    exit 1
fi

echo "deleting temp docker volume"
docker volume rm tmp_deb

echo "deleting temp docker image"
docker rmi tmp_deb_img