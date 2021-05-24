#!/bin/bash

# Colour escape codes
CYAN='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

function wait_termination() {
    printf "\n❌ ${GREEN}Waiting for Terminating items ... "
    sleep 2
    while [ $? -eq 0 ]; do
    kubectl get all -A 2>/dev/null | grep Terminating >/dev/null
    done
    echo -e "${CYAN}done${NC}\n"
}

echo -e "❌ ${GREEN}Removing statefulset.apps/ubuntu - ${CYAN}kubectl delete statefulset.apps/ubuntu --wait=true${NC}"
kubectl delete statefulset.apps/ubuntu --wait=true
wait_termination

echo -e "🔍 ${GREEN}Capturing PV from PVC - task-pv-claim - ${CYAN}kubectl get pvc/task-pv-claim -o jsonpath={'.spec.volumeName'}${NC}"
PV=$(kubectl get pvc/task-pv-claim -o jsonpath={'.spec.volumeName'})

echo -e "\n❌ ${GREEN}Removing pvc/task-pv-claim - ${CYAN}kubectl delete pvc/task-pv-claim --wait=true${NC}"
kubectl delete pvc/task-pv-claim --wait=true

if [ ! -z ${PV} ]
then
    echo -e "\n❌ ${GREEN}Checking clean-up - ${CYAN}kubectl -n kube-system exec -it cli -- storageos get volumes${NC}"
    while [ $? -eq 0 ]; do
    echo polling - 
    kubectl -n kube-system exec -it cli -- storageos get volumes | tee /tmp/out.txt
    egrep "${PV}" /tmp/out.txt >/dev/null && sleep 1
    done
    rm -rf /tmp/out.txt
fi
