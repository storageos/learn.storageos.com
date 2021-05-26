#!/bin/bash

# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

for entry in development production topsecret archive
do
echo -e "✨ ${GREEN}Creating StorageOS Persistent Volume Claim and Persistent Volume - ${entry} - ${CYAN}kubectl apply -f- <<EOF"

read -r -d '' YAML << EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ${entry}
spec:
  storageClassName: ${entry}
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF

echo -e "${YAML}\nEOF${NC}"

kubectl apply -f- <<< "$YAML"
done
