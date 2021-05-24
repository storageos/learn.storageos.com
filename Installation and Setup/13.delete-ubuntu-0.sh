#!/bin/bash

# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "🔍 ${GREEN}Deleting pod ubuntu-0 - ${CYAN}kubectl delete pod/ubuntu-0 --grace-period=0 --wait=true${NC}"
kubectl delete pod/ubuntu-0 --grace-period=0 --wait=true
