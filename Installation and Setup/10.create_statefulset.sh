#!/bin/bash

# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "✨ ${GREEN}Creating Ubuntu Statefulset with StorageOS Persistent Volume - ${CYAN}kubectl apply -f- <<EOF"

read -r -d '' YAML << EOF
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: ubuntu
spec:
  selector:
    matchLabels:
      app: ubuntu
  serviceName: ubuntu
  replicas: 1
  template:
    metadata:
      labels:
        app: ubuntu
    spec:
      volumes:
      - name: task-pv-storage
        persistentVolumeClaim:
          claimName: task-pv-claim
      containers:
        - name: ubuntu
          image: ubuntu
          imagePullPolicy: Always
          command: ["/bin/sleep"]
          args: [ "infinity" ]
          volumeMounts:
          - mountPath: "/data"
            name: task-pv-storage
EOF

echo -e "${YAML}\nEOF${NC}"

kubectl apply -f- <<< "$YAML"
