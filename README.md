# Kubernetes on AWS EC2 with Ubuntu - Resources and Scripts

Welcome to our extensive repository of resources and scripts, tailored for deploying Kubernetes on AWS EC2 instances running Ubuntu. This collection is part of my ambassador contribution and is designed to aid both beginners and seasoned practitioners in their Kubernetes journey.

As cloud computing and containerization continue to revolutionize the tech landscape, understanding how to leverage these technologies is crucial. This repository focuses on AWS, one of the leading cloud service providers, and demonstrates how to set up and manage Kubernetes clusters on EC2 instances, specifically with Ubuntu as the operating system.

## Repository Overview

Within this repository, you'll find a variety of materials that cover different aspects of Kubernetes, all within the context of AWS EC2 and Ubuntu:

- **[ReplicaSet](https://github.com/manikcloud/k8s/tree/main/ReplicaSet):** YAML configurations for Kubernetes ReplicaSets, demonstrating the management of replica Pods.
- **[Deployment](https://github.com/manikcloud/k8s/tree/main/deployment):** Advanced deployment configurations to explore Kubernetes deployments on AWS EC2.
- **[Docker](https://github.com/manikcloud/k8s/tree/main/docker):** Scripts and Dockerfiles for building and managing Docker containers, a key component of Kubernetes workloads on Ubuntu systems.
- **[Installation](https://github.com/manikcloud/k8s/tree/main/installation):** Scripts to simplify the installation of Kubernetes and Docker on Ubuntu, specifically tailored for AWS EC2 environments.
- **[K8s-Kops-Installation](https://github.com/manikcloud/k8s/tree/main/k8s-kops-installation):** Resources for managing Kubernetes clusters using `kops`, with a focus on AWS.
- **[Pods](https://github.com/manikcloud/k8s/tree/main/pods):** Configurations for various types of Kubernetes Pods, showcasing pod deployment on AWS EC2.
- **[Resources](https://github.com/manikcloud/k8s/tree/main/resources):** A collection of Kubernetes resource configurations, essential for AWS-based Kubernetes architecture.
- **[Services](https://github.com/manikcloud/k8s/tree/main/services):** Kubernetes Services configurations for exposing applications on EC2 instances.

## Getting Started

For a detailed guide on setting up a Kubernetes cluster on AWS EC2 using Ubuntu, check out our comprehensive blog post: ["Setting Up a Kubernetes Cluster on AWS EC2 with Ubuntu 22.04 LTS and Kubeadm"](https://varunmanik1.medium.com/setting-up-a-kubernetes-cluster-on-aws-ec2-with-ubuntu-22-04-lts-and-kubeadm-5c54930a4659?source=user_profile---------0----------------------------).

## Contribution

As a part of the ambassador program, I encourage community contributions to this repository. Feel free to enhance existing scripts, add new resources, or improve documentation, keeping in line with the theme of Kubernetes on AWS EC2 and Ubuntu.

Happy Kubernetes-ing on AWS!

---

*Disclaimer: The content in this repository is for educational purposes and should be used with caution. Always review and test configurations in non-production environments.*
---


# k8s Kubernetes Installation and Cluster Setup


- Kubernetes installation and basic setup

## Steps to be followed:
1.	Installing Kubernetes
2.	Setting up a Kubernetes cluster

### Step 1: Installing Kubernetes
- 1.1	To download and add the key to allow kubernetes installation, execute the commands mentioned below:

```
sudo su
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo echo deb http://apt.kubernetes.io/ kubernetes-xenial main > /etc/apt/sources.list.d/kubernetes.list
```	 
- 1.2	Update the apt-get package by executing the command mentioned below:
```
sudo apt-get update
```

- 1.3	Install the kubernetes and the tools required to manage it. Run the command mentioned below in the terminal:

```
sudo apt install docker.io kubectl=1.20.5-00 kubeadm=1.20.5-00 kubelet=1.20.5-00
```

## Step 2: Setting up a Kubernetes cluster
- 2.1	Update the apt-get package by executing the command mentioned below:
```
sudo apt-get update
```
- 2.2	To initialize the cluster run the following command on the master node
```
sudo kubeadm init

```

- 2.3	To start using your cluster, you need to run the following on master node:

```
	mkdir -p $HOME/.kube
	sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config 
	sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

- 2.4	You should see a single master node deployed on running the command:
```
sudo kubectl get nodes
``` 

- 2.5	Copy the kubeadm join command that you can see on the screen of your master node

- 2.6	Run the copied kubeadm join command as a root user on the worker node. You can use the terminal only lab as a worker node. Make sure you have Kubernetes installed on the worker node and then run the below command.

```
kubeadm join 172.31.64.38:6443 --token 425qb8.51rbrxc5h862g202 \
    --discovery-token-ca-cert-hash sha256:a502867d97b05820f186e3ee748afddd9142aae4104aee804d30662148138bae

```
- 2.7	On the master node, run the following command to install the weavenet plugin in order to create a network:

```
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 |tr -d '\n')"
 ```
- 2.8	List all the nodes again to check the status of nodes using the command:
```
kubectl get nodes
```

# Pod creation command
```
kubectl run nginx --image=nginx

kubectl run httpd --image=httpd

```
# Installation command all in one

```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo echo deb http://apt.kubernetes.io/ kubernetes-xenial main > /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt install docker.io kubectl=1.20.5-00 kubeadm=1.20.5-00 kubelet=1.20.5-00
sudo apt-get update

service docker start
service docker status 

kubeadm init

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config 
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sleep 1

kubeadm join 172.31.64.38:6443 --token 425qb8.51rbrxc5h862g202 --discovery-token-ca-cert-hash sha256:a502867d97b05820f186e3ee748afddd9142aae4104aee804d30662148138bae

kubectl get pods -n kube-system

```
# Creating network
```
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 |tr -d '\n')"
sudo kubectl get nodes
```
# kubectl commands

```
kubectl get namespace

kubeadm token list
kubectl get namespaces

kubectl get replicationcontroller,services
kubectl get pods -n kube-public
kubectl get pods -n kube-system
kubectl get pods --all-namespaces

kubectl run nginx --image=nginx
kubectl get pods --all-namespaces

kubectl get pods
kubectl get pods -o wide
kubectl describe pod nginx
kubectl get pods
kubectl run nginx --image=httpd
kubectl run httpd --image=httpd
kubectl get pods

service docker status
sudo kubectl get nodes

```
# Pod Creation in Kubernetes

- Steps to be followed:
1.	Creating multi-container pods
2.	Creating a single container pod

## Step 1: Creating multi-container pods
- 1.1	On the master node, create a new file named sample.yaml:
```
sudo su
vi sample.yaml
1.2	Add the following code in the multi-container.yaml file:
https://github.com/manikcloud/k8s/blob/main/pods/multi-container.yaml
```

- 1.3	Use the following command to create the multi-container pod:
```
kubectl create -f sample.yaml
 ```

## Step 2: Creating a single container pod
- 2.1	On the master node, create a single container pod with a tomcat image using the following command:
```
kubectl run tomcat --image=tomcat:8.0
 ```

- 2.2	Check all the running pods
```
kubectl get pods
``` 
- 2.3	To check why exactly a pod is in the pending state, run the command
-- kubectl describe pods <pod_name>
- To check why multi-container pod is pending,use the command
```
kubectl describe pods multi-container
```
 
 
## 2.4	To remove the taint from the node run the following commands:
```
kubectl get nodes
```
- Copy the node name and use it in the below command
- kubectl taint nodes  <node name> node-role.kubernetes.io/master-

### Here for example we use the command given below
```
kubectl taint nodes  ip-172-31-17-206 node-role.kubernetes.io/master-
 ```
-- 2.5	Now check the pod status. The pods should be in the running state.
```
sudo kubectl get pods 

```

# Dashboard Creation in Kubernetes 

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.1/aio/deploy/recommended.yaml

kubectl proxy

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | awk '/^deployment-controller-token-/{print $1}') | awk '$1=="token:"{print $2}'

kubectl -n kube-system describe secret $(
  kubectl -n kube-system get secret | \
  awk '/^deployment-controller-token-/{print $1}'
) | \
awk '$1=="token:"{print $2}'

```
## After executing the above commands, there are 4 distinct commands and they get called in this order:

- Line 1 - This is the second command from @silverfox's Token section.
- Line 2 - This is the first command from @silverfox's Token section.
- Line 3 - Print only the first field of the line beginning with deployment-controller-token- (which is the pod name)
- Line 5 - Print only the second field of the line whose first field is "token:"

# ReplicaSet commands in K8S

```

kubectl apply -f ReplicaSet/ReplicaSet.yaml 
kubectl get pods
kubectl get replicaset 
kubectl delete pod sl-replicaset-hnd76
kubectl descr
kubectl apply -f pods/pod-def.yaml 
kubectl get pods
kubectl apply -f pods/pod-def.yaml 
kubectl get pods
kubectl get replicaset sl-replicaset
kubectl edit replicaset sl-replicaset
kubectl get replicaset sl-replicaset
kubectl scale replicaset sl-replicaset --replicas=2
kubectl get replicaset sl-replicaset
 
kubectl get replicaset sl-replicaset
```
# Deployment commands in K8S
```
kubectl create -f deployment/deployment.yaml 
kubectl get pods -o wide

kubectl get deployment
kubectl get deployment -o wide
kubectl describe deployment
kubectl create -f deployment/deployment.yaml 
kubectl get pods -o wide 
kubectl rollout history deployment/web-app-deployment 
kubectl delete deployment web-app-deployment
kubectl get pods -o wide 
kubectl create -f deployment/deployment.yaml  --record
kubectl rollout history deployment/web-app-deployment 
kubectl edit deployment web-app-deployment  --record
kubectl rollout history deployment/web-app-deployment 
kubectl rollout status deployment/web-app-deployment 
kubectl get pods -o wide 
kubectl describe deployment web-app-deployment 
kubectl rollout status deployment/web-app-deployment 
kubectl set image deployment web-app-deployment blue=varunmanik/httpd:v1-blue --record
kubectl get pods -o wide
kubectl rollout history deployment web-app-deployment 
```
# scaling commands in K8S
```	
kubectl scale deployment web-app-deployment --replicas=6
```

# Roll Out
```
kubectl rollout undo deployment/web-app-deployment --to-revision=3
kubectl rollout history deployment web-app-deployment 
```

# Docker testing in you K8S setup 
```
docker build -t varunmanik/httpd:green .
docker run -itd -p 9000:80 varunmanik/httpd:green
docker build -t varunmanik/httpd:blue .
docker run -itd -p 9001:80 varunmanik/httpd:blue
kubectl describe pod green-app | grep -i "IP:"
```

# Services commands in K8S 

```
kubectl create -f services/service-def.yaml 
kubectl describe svc web-app-service
kubectl get svc,pods -o wide
kubectl delete service web-app-service
kubectl get svc,pods -o wide
kubectl scale   deployment/blue-green-deployment --replicas=1
kubectl get svc,pods -o wide
kubectl get svc,pods,deployment -o wide

```


# Cleanup the entire setup 

- Run this command to cleanup
```
sh installation/cleanup.sh
```
- OR copy and paste below commands one by one.

```
docker ps 
kubeadm reset -f
rm -rf /etc/cni /etc/kubernetes /var/lib/dockershim /var/lib/etcd /var/lib/kubelet /var/run/kubernetes ~/.kube/*
v
apt remove -y kubeadm kubectl kubelet kubernetes-cni
sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube* 
sudo apt-get autoremove
sudo rm -rf ~/.kube
docker ps
system restart docker 
systemctl restart docker 
```

# Check your history from below command

```
history | cut -c 8- > history.txt
```

# References
1. https://kubernetes.io/
2. https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
3. https://kubernetes.io/docs/concepts/workloads/pods/
4. https://etcd.io/
5. https://kubernetes.io/docs/reference/kubectl/
6. https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
