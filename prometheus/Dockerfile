FROM ubuntu:20.04
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates && apt-get clean && \
    curl -Lso /tmp/prom.tgz https://github.com/prometheus/prometheus/releases/download/v2.25.2/prometheus-2.25.2.linux-amd64.tar.gz && \
    mkdir -p /opt/prom /prometheus && \
    tar -zxvf /tmp/prom.tgz -C /opt/prom --strip-components=1 && \
    chmod 755 /opt/prom/prometheus && \
    chown -R nobody:nogroup /opt/prom /prometheus && \
    rm -f /tmp/prom.tgz
USER nobody
EXPOSE 9090
WORKDIR /prometheus
ENTRYPOINT [ "/scope/scope", "-z", "/opt/prom/prometheus" ]
CMD ["--config.file=/etc/prometheus/prometheus.yml", \
    "--storage.tsdb.path=/prometheus", \
    "--web.console.libraries=/opt/prom/console_libraries", \
    "--web.console.templates=/opt/prom/consoles", \
    "--enable-feature=remote-write-receiver" ]
