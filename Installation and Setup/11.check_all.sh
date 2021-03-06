#!/bin/bash

# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "š ${GREEN}Checking Statefulsets - ${CYAN}kubectl get statefulset${NC}"
kubectl get statefulset

echo -e "\nš ${GREEN}Checking Pods - ${CYAN}kubectl get pods${NC}"
kubectl get pods

echo -e "\nš ${GREEN}Checking PV's - ${CYAN}kubectl get pv${NC}"
kubectl get pv

echo -e "\nš ${GREEN}Checking PVC's - ${CYAN}kubectl get pvc${NC}"
kubectl get pvc
