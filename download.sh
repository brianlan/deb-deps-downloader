#!/usr/bin/env bash

PACKAGE=$1; shift;
ARCHIVE_DIR="/var/cache/apt/archives"
TAR_PATH="archive.tar"

echo "start to download deb packages and then put them into a tar file"
docker run --rm -v tmp_deb:${ARCHIVE_DIR} -v $(pwd):/__tmp__ deb-deps-downloader /bin/bash -c "apt-get install -y --download-only ${PACKAGE}; tar cvf /__tmp__/${TAR_PATH} ${ARCHIVE_DIR}"

echo "deleting temp docker volume"
docker volume rm tmp_deb
