#!/bin/bash

# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "🔍 ${GREEN}Accessing pod ubuntu-0 - ${CYAN}kubectl exec -it ubuntu-0 -- bash${NC}"
kubectl exec -it ubuntu-0 -- bash
