FROM fluent/fluentd:v1.12.0-debian-1.0
USER root
RUN apt-get update && apt-get install -y --no-install-recommends curl git
RUN gem install fluent-plugin-elasticsearch && \
    gem install specific_install && \
    gem specific_install -l https://gith/sub.com/y-ken/fluent-plugin-anonymizer.git
USER fluent