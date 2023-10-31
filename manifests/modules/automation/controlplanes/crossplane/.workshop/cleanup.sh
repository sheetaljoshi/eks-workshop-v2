#!/bin/bash

echo "Deleting resources created by Crossplane... (this will take several minutes)"

eksctl delete iamserviceaccount --name carts-ack --namespace carts --cluster $EKS_CLUSTER_NAME -v 0 > /dev/null

kubectl delete table items -n carts --ignore-not-found=true > /dev/null

kubectl delete -k /eks-workshop/manifests/modules/automation/controlplanes/crossplane/compositions/composition --ignore-not-found=true > /dev/null

exit 0