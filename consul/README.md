Shop Application Environments
=============================

For running Consul as Docker container see: https://github.com/progrium/docker-consul

Start a new machine and ssh in
------------------------------

```sh
vagrant up
vagrant ssh
```

Start a Consul server on one of the machines
--------------------------------------------
```sh
docker run -d --name consulserver -h consulserver \
    -p 8300:8300 \
    -p 8301:8301 \
    -p 8301:8301/udp \
    -p 8302:8302 \
    -p 8302:8302/udp \
    -p 8500:8500 \
    -p 8600:8600/udp \
    progrium/consul -server -advertise 192.168.1.106 -bootstrap -ui-dir /ui
```

Start a Consul client on each machine (except the server)
---------------------------------------------------------

```sh
docker run -d --name consulclient1 -h consulclient1 \
    -p 8300:8300 \
    -p 8301:8301 \
    -p 8301:8301/udp \
    -p 8302:8302 \
    -p 8302:8302/udp \
    -p 8500:8500 \
    -p 8600:8600/udp \
    progrium/consul -join 192.168.1.106 -advertise 192.168.1.XXX
```

Verify that two nodes have joined the Consul network
-----------------------------------------------------

On any node execute the following command.

```sh
curl localhost:8500/v1/catalog/nodes
```
