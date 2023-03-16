#!/bin/sh

docker build -t microservice-kubernetes-demo-apache apache

docker build -t microservice-kubernetes-demo-catalog microservice-kubernetes-demo-catalog

docker build --tag=microservice-kubernetes-demo-customer microservice-kubernetes-demo-customer

docker build -t microservice-kubernetes-demo-order microservice-kubernetes-demo-order
