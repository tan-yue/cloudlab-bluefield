#!/bin/bash

if [ -f /local/startup_service_done ]; then
    exit 0
fi

# prepare BlueField
dpkg -i /mydata/doca-host-repo-ubuntu2204_2.2.0-0.0.3.2.2.0080.1.23.07.0.5.0.0_amd64.deb
apt update && sudo apt upgrade -y
apt install rshim=2.0.7 -y
apt install openvswitch-common=2.17.8-1 -y
apt install openvswitch-switch=2.17.8-1 -y
apt install ibutils2=2.1.1-0.1.MLNX20230719.gbbfde94d.2307050 -y
apt install doca-runtime doca-tools doca-sdk -y
## from this https://groups.google.com/g/cloudlab-users/c/Xk7F46PpxJo
## we can wget as well
## wget https://content.mellanox.com/BlueField/BFBs/Ubuntu22.04/DOCA_2.2.0_BSP_4.2.0_Ubuntu_22.04-2.23-07.prod.bfb
bfb-install --bfb /mydata/DOCA_2.2.0_BSP_4.2.0_Ubuntu_22.04-2.23-07.prod.bfb --config /local/repository/bf.cfg --rshim rshim0
## for sshing into the BF card
ifconfig tmfifo_net0 192.168.100.1 netmask 255.255.255.0

# install NVIDIA drivers, cuda toolkit
apt install -y ubuntu-drivers-common
ubuntu-drivers install --gpgpu

## query the installed NVIDIA driver version
version=$(dpkg-query --show nvidia-kernel-common-* | awk '{print $1}' | awk -F'-' '{print $4"-" $5}')
apt install -y nvidia-utils-$version nvidia-driver-$version nvidia-cuda-toolkit

# install pip
apt install -y python3-pip

> /local/startup_service_done
