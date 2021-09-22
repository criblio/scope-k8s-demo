# apiserver

## Dockerfile

Creates a simple container containing a simple nodejs/express application that runs on port 4000. If the environment variable `DISABLE_ACCESS_COUNT` is not set, the application will intentionally consume too many files, running the system out of open files. It uses the LogStream collectors as a traffic generator.

## apiserver.k8s.yml

Defines the k8s deployment, including injecting the `DISABLE_ACCESS_COUNT`environment variable for the baddev deployment

### K8s Deployment
* Deployment - apiserver - with DISABLE_ACCESS_COUNT set to 1 to keep it from opening too many files.
* Service - apiserver - the ClusterIP service for the apiserver deployment.
* Deployment - baddev - without the `DISABLE_ACCESS_COUNT` env var, so that it actually causes the container to crash and restart repeatedly due to file descriptor starvation.  
* Service - baddev - the ClusterIP service for the baddev deployment.

### collector
These deployments use a LogStream collector hitting the `/randusers/<n>` endpoint to find users to collect and then collecting against those individual users, running the service out of file descriptors. 