# deb-deps-downloader
Download all the dependent debs in Ubuntu given your required package name

__Prerequisite__:
* Docker Engine ([how to install](https://docs.docker.com/engine/installation/))

__Usage__:
```sh
bash download.sh <ubuntu_version> <package_name> [in_china]
```

__Example__:
```sh
bash download.sh 16.04 libopenblas-dev in_china
```

After this script finished running, you will get an file named __*libopenblas-dev.tar.gz*__ in your current folder. Unzip it and use _dpkg -i_ to install those debs.
