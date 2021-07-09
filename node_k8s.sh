#!/bin/bash

#sudo su
apt-get update
swapoff -a
UUID=$(cat /etc/fstab |grep errors=remount)
line2=$(cat /etc/fstab |grep umask)
line3=$(cat /etc/fstab |grep exec)
rm /etc/fstab
echo "$UUID" >> /etc/fstab
echo "$line2" >> /etc/fstab
echo "$line3" >> /etc/fstab

sudo -u root echo "node1" > /etc/hostname


ip_add=$(ip -4 addr show ens33 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
hostname=$(cat /etc/hostname)
echo $ip_add $hostname >> /etc/hosts
rm /etc/network/interfaces
touch /etc/network/interfaces 
echo "auto enp0s8" >> /etc/network/interfaces
echo "iface enp0s8 inet static" >> /etc/network/interfaces
echo "address $ip_add" >> /etc/network/interfaces

sudo apt-get install -y  openssh-server

apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update

apt-get install -y kubelet kubeadm kubectl 

echo "Environment=”cgroup-driver=systemd/cgroup-driver=cgroupfs”" >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

#masterip=$(kubectl describe nodes master |grep InternalIP | tr -d 'InternalIP:')

#sudo kubeadm join --apiserver-advertise-address=$masterip --pod-network-cidr=192.168.0.0/16
