#!/bin/bash

# Bash script to help with sdc demo, calling various docker commands.
# Requirements: kubeadm, kubectl.
# Install instructions:
#   https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl.

# SETUP NOTE:
# Needed to specify environment for Kubernetes v1.8.
# echo 'Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"'
#   > /etc/systemd/system/kubelet.service.d/90-local-extras.conf
# Reference: https://github.com/kubernetes/kubernetes/issues/53333

# Check arguments.
if [[ $# -ne 1 ]]; then
  echo "Usage: sdc-demo-helper {create, start, sdc, mysql, cdh, mongo, stop, destroy}."
  exit 1
fi

# Setup kubeadm, restart kubelet and docker, rebuild docker images.
if [[ $1 == "create" ]]; then

  # Setup kubeadm, restart kubelet and docker.
  sudo kubeadm reset
  sudo systemctl restart kubelet
  echo "Restarted kubelet."
  sudo systemctl restart docker
  echo "Restarted docker."
  sudo kubeadm init  #--pod-network-cidr=10.244.0.0/16
  export KUBECONFIG=/etc/kubernetes/admin.conf
  #minikube start --kubernetes-version v1.8.0 --bootstrapper kubeadm
  #eval $(minikube docker-env)

  # Rebuild docker images
  #docker build -t data-collector:v1 ./data-collector

# Build storage network, create services.
elif [[ $1 == "start" ]]; then

  # CHANGE THIS TO BE MY NETWORK

  for i in pv0001 pv0002 pv0003 pv0004
  do
    ssh -q ~/.minikube/machines/minikube/id_rsa root@$(minikube ip) && \
      mkdir -p /srv/data/$i && \
      chmod 777 /srv/data/$i && \
      chcon -Rt svirt_sandbox_file_t /srv/data/$i
  done

  kubectl apply -f sdc-demo-pv.yml
  kubectl apply -f sdc-demo-objects.yml

# Exec into sdc container, make some pipelines.
elif [[ $1 == "sdc" ]]; then
  kubectl exec -it streamsets-sdc-demo -c data-collector -- /bin/sh

# Exec into mysql container.
elif [[ $1 == "mysql" ]]; then
  kubectl exec -it streamsets-sdc-demo -c mysql -- /bin/bash

# Shut down services.
elif [[ $1 == "stop" ]]; then
  # kubectl delete -f ./run-services-k8s.yml
  # eval $(minikube docker-env -u)
  echo "no"

elif [[ $1 == "destroy" ]]; then
  sudo kubeadm reset

# Error if bad entry.
else
  echo "Usage: sdc-demo-helper {create, start, sdc, mysql, cdh, mongo, stop, destroy}."
  exit 1
fi
