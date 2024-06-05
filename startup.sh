sudo dpkg -i /mydata/doca-host-repo-ubuntu2204_2.2.0-0.0.3.2.2.0080.1.23.07.0.5.0.0_amd64.deb
sudo apt update && sudo apt upgrade -y
sudo apt install rshim=2.0.7 -y
sudo apt install openvswitch-common=2.17.8-1 -y
sudo apt install openvswitch-switch=2.17.8-1 -y
sudo apt install ibutils2=2.1.1-0.1.MLNX20230719.gbbfde94d.2307050 -y
sudo apt install doca-runtime doca-tools doca-sdk -y
sudo bfb-install --bfb /mydata/DOCA_2.2.0_BSP_4.2.0_Ubuntu_22.04-2.23-07.prod.bfb --config /local/repository/bf.cfg --rshim rshim0
