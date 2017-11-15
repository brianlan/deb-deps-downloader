#!/usr/bin/env bash

ARCHIVE_DIR="/var/cache/apt/archives"

if [ $# -lt 2 ]
  then
    echo "Invalid number of arguments. Usage: download.sh <ubuntu_version> <package_name> [in_china]"
    exit 1
fi

UBT_VER=$1; shift;
PACKAGE=$1; shift;
IN_CHINA=$1; shift;

TAR_PATH="${PACKAGE}.tar.gz"

if [ "${IN_CHINA}" == "in_china" ]
  then
    dockerfilename="Dockerfile.china"
  else
    dockerfilename="Dockerfile"
fi

echo "start to build docker image"
docker build -t tmp_deb_img --build-arg ubuntu_version=${UBT_VER} -f ${dockerfilename} .

if [ $? -ne 0 ]
  then
    echo "Error found during building docker image. Process aborted and wait for cleaning."
    exit 1
fi

echo "start to download deb packages and then put them into a tar file"
docker run --rm -v tmp_deb:${ARCHIVE_DIR} -v $(pwd):/__tmp__ tmp_deb_img \
      /bin/bash -c "apt-get install -y --download-only ${PACKAGE}; tar czvf /__tmp__/${TAR_PATH} ${ARCHIVE_DIR}"
#docker run -d -v tmp_deb:${ARCHIVE_DIR} -v $(pwd):/__tmp__ tmp_deb_img \
#      /bin/bash -c "apt-get install -y --download-only ${PACKAGE}; tail -f /dev/null"

echo "deleting temp docker volume"
docker volume rm tmp_deb

echo "deleting temp docker image"
docker rmi tmp_deb_img
