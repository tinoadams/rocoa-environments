#!/usr/bin/env bash

# install apt tools eg. add-apt-repository
apt-get update
apt-get install -y software-properties-common python-software-properties

# install JDK 7
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository -y ppa:webupd8team/java && \
apt-get update && \
apt-get install -y oracle-java7-installer && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk7-installer

# Define commonly used JAVA_HOME variable
echo 'export JAVA_HOME=/usr/lib/jvm/java-7-oracle' >> /etc/environment

# install SBT
echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
apt-get update && \
apt-get install -y sbt

# clone shop services
su - vagrant -c 'cd /vagrant && git clone https://github.com/tinoadams/rocoa-catalogue.git'

# run SBT for the first time 
su - vagrant -c 'cd /vagrant/rocoa-catalogue && sbt tasks'
