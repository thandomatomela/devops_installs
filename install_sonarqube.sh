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

