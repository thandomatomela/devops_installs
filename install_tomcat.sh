#!/bin/bash

cd /opt
wget http://mirrors.fibergrid.in/apache/tomcat/tomcat-8/v8.5.35/bin/apache-tomcat-8.5.35.tar.gz
tar -xvzf /opt/apache-tomcat-8.5.35.tar.gz
mv apache-tomcat-8.5.35 tomcat
chmod +x /opt/apache-tomcat-8.5.35/bin/startup.sh 
shutdown.sh
ln -s /opt/apache-tomcat-8.5.35/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/apache-tomcat-8.5.35/bin/shutdown.sh /usr/local/bin/tomcatdown
tomcatup
