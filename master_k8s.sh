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

sudo -u root echo "master" > /etc/hostname


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

#kubeadm reset

#systemctl restart kubelet

touch kubeadm_init_output

kubeadm init --apiserver-advertise-address=$ip_add --pod-network-cidr=192.168.0.0/16 >> kubeadm_init_output

sudo userdel devops
sudo useradd -m -d /home/devops/ -s /bin/bash -G sudo devops
chmod 777 -R /home/devops

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get pods -o wide --all-namespaces

kubectl apply -f https://docs.projectcalico.org/v3.13/manifests/calico.yaml
