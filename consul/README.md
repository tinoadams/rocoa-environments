Shop Application Environment
============================

For running Consul as Docker container see: https://github.com/progrium/docker-consul

Start a new machine
-------------------

Our cluster will be made up of a number of these base machines. We run everything in Docker containers. Which means all our cluster nodes are the same type of base machine which is capable of running Docker containers ie. hosting the Consul server, the Consul clients or some micro-services.

One of the cluster nodes will run the Consul server all other nodes will run the Consul client, Registrator and a few micro-services.

To boot a new cluster node do the following

```sh
vagrant up
vagrant ssh
```

Start a Consul server
---------------------

One of the cluster nodes must host the Consul server.

More elaborate cluster setups are possible to avoid a single point of failure: https://consul.io/docs/guides/bootstrapping.html

```sh
docker run -d --name consulserver -h consulserver \
    -p 8300:8300 \
    -p 8301:8301 \
    -p 8301:8301/udp \
    -p 8302:8302 \
    -p 8302:8302/udp \
    -p 8500:8500 \
    -p 8600:53/udp \
    progrium/consul -server -advertise $PUBLIC_IP -bootstrap -ui-dir /ui
```

Determine Consul server PUBLIC_IP address required by clients to join the cluster.

```sh
echo Consul server public ip address: $PUBLIC_IP
echo Consul server web ui: http://$PUBLIC_IP:8500/ui/dist
```

Start a Consul client
---------------------
A Consul client must be started on each cluster node that will host mirco-services. Consul clients expose configuration and API's to register micro-services and to query the details of a healthy micro-service: https://consul.io/intro/getting-started/services.html

All Consul clients need to join the cluster of Consul nodes by providing each client with the IP address of the Consul server.

Replace **CONSUL_SERVER_IP** below with the PUBLIC_IP address of the Consul server on your network.

```sh
docker run -d --name consulclient1 -h consulclient1 \
    -p 8300:8300 \
    -p 8301:8301 \
    -p 8301:8301/udp \
    -p 8302:8302 \
    -p 8302:8302/udp \
    -p 8500:8500 \
    -p 8600:53/udp \
    progrium/consul -join CONSUL_SERVER_IP -advertise $PUBLIC_IP
```
