#!/bin/sh

kubectl create deployment apache --image=microservice-kubernetes-demo-apache:latest --port=80
kubectl expose deployment apache --type="LoadBalancer" --port 80
kubectl create deployment catalog --image=microservice-kubernetes-demo-catalog:latest --port=8080
kubectl expose deployment catalog --type="LoadBalancer" --port 8080
kubectl create deployment customer --image=microservice-kubernetes-demo-customer:latest --port=8080
kubectl expose deployment customer --type="LoadBalancer" --port 8080
kubectl create deployment order --image=microservice-kubernetes-demo-order:latest --port=8080
kubectl expose deployment order --type="LoadBalancer" --port 8080
