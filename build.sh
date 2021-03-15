#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build -t cribl/scope-k8s-demo-fluentd fluentd
docker push cribl/scope-k8s-demo-fluentd
docker build -t cribl/scope-kis-demo-prometheus prometheus
docker push cribl/scope-k8dockes-demo-prometheus

cd ${DIR}/telegraf
git clone https://github.com/influxdata/telegraf.git
cd telegraf
git checkout v1.17.3
sed -i 's/%.deb %.rpm %.tar.gz %.zip: export LDFLAGS = -w -s/%.deb %.rpm %.tar.gz %.zip: export LDFLAGS = /' Makefile
make telegraf_1.17.3-1_amd64.deb
cd ${DIR}
docker build -t cribl/scope-k8s-demo-telegraf telegraf
docker push cribl/scope-k8s-demo-telegraf
