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

echo "Removing any residual packages and dpendencies..."
sudo apt-get autoremove -y

echo "cleaning up Docker's system files ..."
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

echo "Cleaning up Kubernets configuration files..."
sudo rm -rf /etc/kubernetes/
sudo rm -rf $HOME/.KUBR/

echo "  Remove all folder associated to kubernetes, etcd, "
sudo rm -rf /etc/cni /etc/kubernetes /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/lib/etcd2/ /var/run/kubernetes

echo "cleanup complete."
 
