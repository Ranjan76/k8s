#!/bin/sh
echo "  Kube Admin Reset"
sudo kubeadm reset -f

echo "  Remove all packages related to Kubernetes"
sudo apt remove -y kubeadm kubectl kubelet kubernetes-cni 
sudo apt purge -y kube*

echo "  Remove docker images ( optional if using docker)"
# Note: Docker does not support "-y" for automatic yes to prompt in "docker image prune"
#you can use "yes | command" to auto confirm, be cautious with approach.
sudo docker image prune -a

echo "Removing docker and assoiated packages"
sudo apt-get remove docker-engine docker.io containerd runc -y
apt autoremove -y

echo "  Remove all folder associated to kubernetes, etcd, "
rm -rf ~/.kube
rm -rf /etc/cni /etc/kubernetes /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/lib/etcd2/ /var/run/kubernetes ~/.kube/* 
rm -rf /etc/systemd/system/etcd* 
