# deb-deps-downloader
Download all the dependent debs in Ubuntu given your required package name

__Prerequisite__:
* Docker Engine ([how to install](https://docs.docker.com/engine/installation/))

__Usage__:
```sh
bash download.sh <ubuntu_version> <package_name>
```

__Example__:
```sh
bash download.sh 16.04 libopenblas-dev
```

After this script finished running, you will get an file named __*archive.tar*__ in your current folder.
