Shop Application Environments
=============================

XXXXXXXXXXXXXXXXXXXX

Pre-requisite is that Vagrant (http://www.vagrantup.com/downloads) must be installed on your computer.

## Development environment ##

```sh
$ cd dev-machine
$ vagrant up
$ vagrant ssh
$ cd /vagrant
$ git clone https://github.com/tinoadams/rocoa-catalogue.git
$ cd rocoa-catalogue
$ sbt assembly
```
