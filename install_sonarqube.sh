#! /bin/bash

sudo apt update
sudo apt install -y postgresql postgresql-contrib

cd /opt
sonar_version=sonarqube-9.0.0.45539.zip
sonar_version_folder=sonarqube-9.0.0.45539
wget https://binaries.sonarsource.com/Distribution/sonarqube/$sonar_version
unzip $sonar_version
mkdir sonarqube
mv $sonar_version_folder/* sonarqube/
rm -rf $sonar_version
cd sonarqube
sudo apt update
sudo apt search openjdk
apt install -y openjdk-11-jre-headless
java -version
adduser sonar
chown -R sonar:sonar /opt/sonarqube

sonar.jdc.username=sonar >> /opt/sonarqube/conf/sonar.properties
sonar.jdc.password=sonar >> /opt/sonarqube/conf/sonar.properties
sonar.jdc.url=jdbc:postgresql://localhost/sonar >> /opt/sonarqube/conf/sonar.properties
sonar.path.data=/var/sonarqube/data >> /opt/sonarqube/conf/sonar.properties
sonar.path.temp=/var/sonarqube/temp  >> /opt/sonarqube/conf/sonar.properties

