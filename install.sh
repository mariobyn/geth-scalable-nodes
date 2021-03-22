#!/bin/bash

sed -i -e 's;{{image}};'$1';g' k8s/*

# create geth namespace
kubectl create namespace geth
cd docker   
if [ "$2" == "full" ]; then
  docker build -t $1-full -f Dockerfile-full .
  docker push $1-full
else
  docker build -t $1-fast -f Dockerfile-fast .
  docker push $1-fast
fi

docker build -t $1-light -f Dockerfile-light .
docker push $1-light

cd ..
cd k8s
kubectl apply -f pvc-chain-light.yaml

kubectl apply -f pvc-keystore-geth-light-clients.yaml

if [ "$2" == "full" ]; then
  kubectl apply -f sts-geth-full.yaml
else
  kubectl apply -f sts-geth-fast.yaml
fi

kubectl apply -f dep-geth-light.yaml
kubectl apply -f light-svc.yaml


