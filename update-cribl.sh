#!/bin/bash
POD=$(kubectl get po --selector="app.kubernetes.io/name=cribl" -o jsonpath='{.items..metadata.name}')
mkdir -p cribl/local/cribl
kubectl cp $POD:/opt/cribl/config-volume/local/cribl cribl/local/cribl
tar --exclude auth -cz -f cribl-initial-configs.tgz --strip=2 cribl/local/cribl
kubectl create configmap cribl-initial-configs --from-file=cribl-initial-configs.tgz --dry-run=client -o yaml > cribl-configs.k8s.yml
rm cribl-initial-configs.tgz