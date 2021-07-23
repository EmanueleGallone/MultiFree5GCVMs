#!/bin/bash

#this interface is the one connecting the vm to Internet.
INTERFACE="'eth0'"

#install basic packages
sudo apt-get update
sudo apt-get install curl git net-tools ansible -y

# install docker
if [[ $(which docker) && $(docker --version) ]]; then
    echo "skipping docker install"
  else
    echo "Install docker"
    curl -fsSL https://get.docker.com | sh
    sudo groupadd docker
    sudo usermod -aG docker $USER
fi

#clone Netsoft free5gc repo and install
git clone https://github.com/EmanueleGallone/NetSoft2020-Tutorial4-Demo2-Exp1.git
cd NetSoft2020-Tutorial4-Demo2-Exp1/
ansible-playbook -K Demo2Exp1.yml  -e  "internet_network_interface=$INTERFACE" --extra-vars "ansible_become_pass=root"
