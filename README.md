This profile provisions `num_nodes` (by default 4) r7525 nodes that are connected via two LANs through the two BlueField ports.

Each node has a read-only dataset mounted at
/mydata that contains the DOCA host deb image and the DOCA BlueField image.

The provisioning will execute the installation script [startup.sh](./startup.sh). The script will take a while to complete. One can tell if the script completes by checking if /local/start_service_done exists.

Reboot seems to be needed for nvidia-smi to work with NVIDIA drivers properly.
