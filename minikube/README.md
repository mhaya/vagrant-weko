# minikube

## install minikube

```
vagrant up
```

When install process is fail, run provisioning command manually.

```
vagrant up --provision
```


running log:

```
% vagrant up --provision
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Checking if box 'bento/ubuntu-20.04' version '202012.23.0' is up to date...
==> default: Running provisioner: ansible...
    default: Running ansible-playbook...

PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [192.168.10.20]

TASK [disk : Check disk size] **************************************************
changed: [192.168.10.20]

TASK [disk : Extend disk size] *************************************************
changed: [192.168.10.20]

TASK [selinux-disabler : Update repositories cache] ****************************
ok: [192.168.10.20]

TASK [selinux-disabler : Install build-essential] ******************************
ok: [192.168.10.20]

TASK [selinux-disabler : Install the libselinux-python package] ****************
ok: [192.168.10.20]

TASK [sysctl : configure vm.max_map_count] *************************************
ok: [192.168.10.20]

TASK [sysctl : Reboot the machine (Wait for 5 min)] ****************************
skipping: [192.168.10.20]

TASK [docker : Add docker GPG key] *********************************************
ok: [192.168.10.20]

TASK [docker : Install basic list of packages] *********************************
ok: [192.168.10.20]

TASK [docker : Add apt repository] *********************************************
ok: [192.168.10.20]

TASK [docker : Install Docker packages] ****************************************
ok: [192.168.10.20]

TASK [docker : Add user to docker group] ***************************************
ok: [192.168.10.20]

TASK [docker : Ensure docker service is enabled] *******************************
ok: [192.168.10.20]

TASK [docker : Install docker-compose] *****************************************
ok: [192.168.10.20]

TASK [minikube : Set sysctl] ***************************************************
ok: [192.168.10.20]

TASK [minikube : Install GlusterFS] ********************************************
ok: [192.168.10.20]

TASK [minikube : Install conntrack] ********************************************
ok: [192.168.10.20]

TASK [minikube : download kubectl] *********************************************
ok: [192.168.10.20]

TASK [minikube : download Minikube] ********************************************
ok: [192.168.10.20]

TASK [minikube : install Minikube] *********************************************
ok: [192.168.10.20]

TASK [minikube : start Minikube] ***********************************************
changed: [192.168.10.20]

TASK [minikube : download Helm] ************************************************
ok: [192.168.10.20]

TASK [minikube : install Helm] *************************************************
changed: [192.168.10.20]

PLAY RECAP *********************************************************************
192.168.10.20              : ok=23   changed=4    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```

## login minikube server

connect the minikube server.

```
vagrant ssh
```

check the running pods.

```
$ kubectl get pods -A
NAMESPACE     NAME                               READY   STATUS    RESTARTS        AGE
kube-system   coredns-78fcd69978-bscd7           1/1     Running   1 (14m ago)     16m
kube-system   etcd-minikube                      1/1     Running   1 (14m ago)     16m
kube-system   kube-apiserver-minikube            1/1     Running   1 (9m19s ago)   16m
kube-system   kube-controller-manager-minikube   1/1     Running   1 (14m ago)     16m
kube-system   kube-proxy-m2k4p                   1/1     Running   1 (14m ago)     16m
kube-system   kube-scheduler-minikube            1/1     Running   1 (9m19s ago)   16m
kube-system   storage-provisioner                1/1     Running   3 (8m31s ago)   16m
```

```
minikube addons enable storage-provisioner-gluster
```

running following command, to use the docker engine.

```
eval $(minikube docker-env)
```

## build WEKO3 images

checkout WEKO3 repository.

```
cd /vagrant/tmp/
git clone https://github.com/RCOSDP/weko.git
cd weko
```

change the Dockerfile to bulid docker images for k8s.

```
sed -i 's/#RUN mv /RUN mv /g' Dockerfile
```

build docker images.

```
docker-compose build
```

Check the built docker images.

```
$ docker images
REPOSITORY                                          TAG               IMAGE ID       CREATED              SIZE
weko_nginx                                          latest            3c35551ac534   57 seconds ago       320MB
<none>                                              <none>            7c27e1221b40   About a minute ago   775MB
weko_web                                            latest            3c7181046c18   4 minutes ago        3.39GB
weko_elasticsearch                                  latest            0dd9dba4cc30   13 minutes ago       520MB
python                                              3.6-slim-buster   eb32e0d643ed   5 days ago           112MB
ubuntu                                              focal             ba6acccedd29   5 weeks ago          72.8MB
gcr.io/k8s-minikube/kicbase                         v0.0.28           e2a6c047bedd   7 weeks ago          1.08GB
docker.elastic.co/elasticsearch/elasticsearch-oss   6.2.2             0453814a47b3   3 years ago          483MB
```

## deploy WEKO3 into k8s

checkout weko-k8s repository.

```
cd /vagrant/tmp
git clone https://github.com/RCOSDP/weko-k8s.git
cd weko-k8s
git checkout origin/minikube -b minikube
```

### deploy postgresql cluster

deploy postgresql cluster.

```
cd deploy/postgresql/
kubectl apply -f namespace.yaml
kubectl apply -f secret.yaml
kubectl apply -f config.yaml
kubectl apply -f service1.yaml
kubectl apply -f service2.yaml
kubectl apply -f node1.yaml
kubectl apply -f node2.yaml
kubectl apply -f pgpool.yaml
```

check the deployed pods status.

```
$ kubectl get pods -n weko3pg
NAME                            READY   STATUS    RESTARTS   AGE
weko3pg-db-node1-0              1/1     Running   0          105s
weko3pg-db-node2-0              1/1     Running   0          105s
weko3pg-pgpool-6499f88d-bj554   1/1     Running   0          104s
```


### deploy elasticsearch 

move elasticsearch directory.

```
cd ../elasticsearch/
```

load local image on minikube.

```
minikube image load weko_elasticsearch:latest --daemon
```

deploy elasticsearch.

```
kubectl apply -f namespace.yaml
kubectl apply -f service.yaml
kubectl apply -f elasticsearch.yaml
```

```
$ kubectl get pods -n weko3es
NAME                   READY   STATUS    RESTARTS   AGE
weko-elasticsearch-0   1/1     Running   0          9m4s
```

### deploy rabbitmq





```
cd ../rabbitmq/
kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
```

```
$ kubectl get all -n rabbitmq-system
NAME                                             READY   STATUS    RESTARTS   AGE
pod/rabbitmq-cluster-operator-7cbf865f89-hrgt6   1/1     Running   0          111m

NAME                                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/rabbitmq-cluster-operator   1/1     1            1           111m

NAME                                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/rabbitmq-cluster-operator-7cbf865f89   1         1         1       111m
```

```
$ kubectl get customresourcedefinitions.apiextensions.k8s.io
NAME                            CREATED AT
rabbitmqclusters.rabbitmq.com   2021-11-23T11:19:19Z
```

```
kubectl apply -f namespace.yaml
kubectl apply -f deploy.yaml
```

minikube ssh sudo chmod 777 /data/ravolume

```
kubectl exec -n weko3ra weko3-server-0 -c rabbitmq -- rabbitmqctl add_user invenio rapass123
```

```
$ kubectl get pods -n weko3ra
NAME             READY   STATUS    RESTARTS   AGE
weko3-server-0   1/1     Running   0          6m9s
```

```
kubectl apply -f ingress.yaml
```

#

```
cd ../weko/
kubectl apply -f namespace.yaml
kubectl apply -f weko-secret.yaml
```

```
$ kubectl exec -it -n weko3ra weko3-server-0 -c rabbitmq -- rabbitmqctl add_vhost weko3-example-org/
Adding vhost "weko3-example-org/" ...
```

```
$ kubectl exec -it -n weko3ra weko3-server-0 -c rabbitmq -- rabbitmqctl set_permissions -p weko3-example-org/ invenio ".*" ".*" ".*"
Setting permissions for user "invenio" in vhost "weko3-example-org/" ...
```

```
$ ./helm_deploy.sh --env minikube weko3.example.org   --set container.nginx.image=weko_nginx:latest   --set container.web.image=weko_web:latest   --set config.WEKO_ACCOUNTS_SHIB_LOGIN_ENABLED=False
upgrade
weko3.example.org
--set container.nginx.image=weko_nginx:latest --set container.web.image=weko_web:latest --set config.WEKO_ACCOUNTS_SHIB_LOGIN_ENABLED=False
Release "weko3.example.org" has been upgraded. Happy Helming!
NAME: weko3.example.org
LAST DEPLOYED: Tue Nov 23 16:28:37 2021
NAMESPACE: weko3
STATUS: deployed
REVISION: 3
TEST SUITE: None
```


```
$ helm list -n weko3
NAME             	NAMESPACE	REVISION	UPDATED                                	STATUS  	CHART    	APP VERSION
weko3.example.org	weko3    	3       	2021-11-23 16:28:37.299203355 +0000 UTC	deployed	tmp-0.1.0	1.16.0
```