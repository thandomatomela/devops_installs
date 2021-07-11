#!/bin/bash

cd /opt
wget https://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz
tar -xvzf apache-maven-3.8.1-bin.tar.gz
mv apache-maven-3.8.1 maven
cd maven
apr-get install maven

echo "M2_HOME=/opt/maven" >> ~/.bash_profile
echo "M2=/opt/maven/bin" >> ~/.bash_profile
echo "PATH=$PATH:$HOME/bin:$M2:$M2_HOME" >> ~/.bash_profile
echo "export PATH" >> ~/.bash_profile
mvn --version 
