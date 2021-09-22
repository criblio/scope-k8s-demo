FROM node:lts
ADD . /opt/apiserver
RUN  cd /opt/apiserver && npm install
ADD customer_master_small.csv /data/customer_master_small.csv
CMD ["sh", "-c", "ulimit -n 1024; exec /usr/local/bin/node /opt/apiserver/server.js"]
