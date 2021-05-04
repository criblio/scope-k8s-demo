# AppScope Kubernetes Demo

This demo environment uses [AppScope](https://appscope.dev/) to instrumental containers running in a our demo environment. AppScope provides black box instrumentation that can help you collect performance information and logs from any running Linux process, no matter the runtime. The `scope` CLI makes installing AppScope in Kubernetes as simple as a single command. AppScope installs a [mututating admission webhook](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/) automatically scopes any new container starting up in a namespace with the label `scope=enabled`. Read more about AppScope in our docs [here](https://appscope.dev/docs/overview), and read more about the Kubernetes feature here (coming).

## Prerequisites
For this demo environment, you will need Docker, `bash`, and a few Kubernetes utilties: `kubectl`, `kind` and `helm`. `start.sh` uses `kind` to create a Kubernetes environment running in Docker, then we use `kubectl` and `helm` to install Elasticsearch, Kibana, Prometheus, and Grafana. By default, AppScope will send to Fluentd and Telegraf which will send to Elasticsearch and be scraped by Prometheus, or, you can send the data to Cribl LogStream instead, where we will also do some reshaping of the data in LogStream to make it easy to route it anywhere and to help control volume.

Here are installation instructions for `kubectl`, `kind`, and `helm`:

### MacOS
For MacOS, we recommend [Homebrew](https://brew.sh) to make installing these utilities simple.
```bash
brew install kind
brew install kubectl
brew install helm
```

### Linux
```bash
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
&& sudo install kubectl /usr/local/bin && rm kubectl
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.10.0/kind-linux-amd64 && sudo install kind /usr/local/bin && rm ./kind
```

## Running the Demo

To run the demo, simply run `start.sh`:

```bash
./start.sh
```

This will stand up Elasticsearch, Kibana, Grafana, Prometheus, Fluentd and Telegraf, all scoped, in Kubernetes. The demo automatically instruments those applications, feeding itself data from scoping itself. How meta! Inside the environment, there are dashboards in Grafana and Kibana that help you see the type of data we collect with AppScope. 

|Service|URL|
|-------|---|
|Grafana|[http://localhost:30003](http://localhost:30003)|
|Kibana|[http://localhost:30001](http://localhost:30001)|
|Prometheus|[http://localhost:30002](http://localhost:30002)|

Check out the AppScope dashboards in Grafana and Kibana!

For Grafana's login credential, see `grafana.values.yml`

## Clean up

To clean up the demo, simply run `stop.sh`:

```bash
./stop.sh
```
